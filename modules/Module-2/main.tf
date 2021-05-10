data "azurerm_resource_group" "example" {
  name     = var.resource_group
}

data "azurerm_virtual_network" "example" {
  name                = var.v_net
  resource_group_name = var.resource_group
}

data "azurerm_subnet" "trust" {
  name                 = var.sub_net
  virtual_network_name = var.v_net
  resource_group_name  = var.resource_group
}

data "azurerm_network_security_group" "example" {
  name                = "mg-tf-mongonsg"
  resource_group_name = var.resource_group
}

# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  name                = var.publicip
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  allocation_method   = var.public_ip_address_allocation

  tags = {
    environment = "production"
  }
}

resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.trust.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "association" {
  network_interface_id      = azurerm_network_interface.example.id
  network_security_group_id = data.azurerm_network_security_group.example.id
}

resource "azurerm_linux_virtual_machine" "linuxvm" {
  name                  = var.linux_virtual_machine
  location              = data.azurerm_resource_group.example.location
  resource_group_name   = data.azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example.id]
  size                  = var.vm_size

  os_disk {
    name                 = "myOsDisk"
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.storage_image_reference.publisher
    offer     = var.storage_image_reference.offer
    sku       = var.storage_image_reference.sku
    version   = var.storage_image_reference.version
  }

  computer_name                   = "myvm"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # boot_diagnostics {
  #   storage_account_uri = azurerm_storage_account.storage.primary_blob_endpoint
  # }

  tags = {
    environment = "production"
  }
}

resource "azurerm_managed_disk" "example" {
  name                 = var.disk_name
  location             = data.azurerm_resource_group.example.location
  resource_group_name  = data.azurerm_resource_group.example.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb

  tags = {
    environment = "staging"
  }
}