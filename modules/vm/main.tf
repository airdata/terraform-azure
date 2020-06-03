// ==================== VM Networks ====================

resource "azurerm_virtual_network" "main" {
  name                            = "${var.prefix}-vnet"
  location                        = var.location
  address_space                   = ["${var.address_space}"]
  resource_group_name             = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                            = "${var.prefix}-subnet"
  virtual_network_name            = azurerm_virtual_network.main.name
  resource_group_name             = var.resource_group_name
  address_prefix                  = var.subnet_prefix
}

resource "azurerm_network_security_group" "tf-azurerm-sg" {
  name                            = "${var.prefix}-sg"
  location                        = var.location
  resource_group_name             = var.resource_group_name

  security_rule {
    name                          = "HTTP"
    priority                      = 100
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "Tcp"
    source_port_range             = "*"
    destination_port_range        = "80"
    source_address_prefix         = var.source_network
    destination_address_prefix    = "*"
  }

  security_rule {
    name                          = "SSH"
    priority                      = 101
    direction                     = "Inbound"
    access                        = "Allow"
    protocol                      = "Tcp"
    source_port_range             = "*"
    destination_port_range        = "22"
    source_address_prefix         = var.source_network
    destination_address_prefix    = "*"
  }
}

resource "azurerm_network_interface" "tf-azurerm-nic" {
  name                            = "${var.prefix}-nic"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  network_security_group_id       = azurerm_network_security_group.tf-azurerm-sg.id

  ip_configuration {
    name                          = "${var.prefix}-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-azurerm-pip.id
  }
}

resource "azurerm_public_ip" "tf-azurerm-pip" {
  name                            = "${var.prefix}-ip"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  allocation_method               = "Dynamic"
  domain_name_label               = var.hostname
}

// ==================== Virtual Mashines ====================

data "template_file" "init" {
  template = "${file("${path.module}/files/init.tpl")}"
  vars = {
    acr_login_server              = var.acr_login_server
    acr_admin_username            = var.acr_admin_username
    acr_admin_password            = var.acr_admin_password
  }
}

resource "azurerm_virtual_machine" "azure-vm" {
  name                            = "${var.hostname}-vm"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  vm_size                         = var.vm_size

  network_interface_ids           = ["${azurerm_network_interface.tf-azurerm-nic.id}"]
  delete_os_disk_on_termination   = "true"

  storage_image_reference {
    publisher                     = var.image_publisher
    offer                         = var.image_offer
    sku                           = var.image_sku
    version                       = var.image_version
  }

  storage_os_disk {
    name                          = "${var.hostname}-osdisk"
    managed_disk_type             = "Standard_LRS"
    caching                       = "ReadWrite"
    create_option                 = "FromImage"
  }

  os_profile {
    computer_name                 = var.hostname
    admin_username                = var.admin_username
    admin_password                = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  provisioner "file" {
    content                       = data.template_file.init.rendered
    destination                   = "/home/${var.admin_username}/setup.sh"

    connection {
      type                        = "ssh"
      user                        = var.admin_username
      password                    = var.admin_password
      host                        = azurerm_public_ip.tf-azurerm-pip.fqdn
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.admin_username}/setup.sh",
      "sudo /home/${var.admin_username}/setup.sh",
    ]

    connection {
      type                        = "ssh"
      user                        = var.admin_username
      password                    = var.admin_password
      host                        = azurerm_public_ip.tf-azurerm-pip.fqdn
    }
  }
}
