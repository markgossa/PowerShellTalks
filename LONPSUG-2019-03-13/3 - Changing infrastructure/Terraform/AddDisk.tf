# Create resource group
resource "azurerm_resource_group" "resourceGroup1" {
  name     = "RG-LONPSUG2"
  location = "West Europe"
}

# Create a virtual network
resource "azurerm_virtual_network" "virtualNetwork1" {
  name                = "VNET0001"
  location            = "${azurerm_resource_group.resourceGroup1.location}"
  resource_group_name = "${azurerm_resource_group.resourceGroup1.name}"
  address_space       = ["10.0.0.0/16"]
}

# Create network security group
resource "azurerm_network_security_group" "networkSecurityGroup1" {
  name                = "NSG-LAN"
  location            = "${azurerm_resource_group.resourceGroup1.location}"
  resource_group_name = "${azurerm_resource_group.resourceGroup1.name}"
}

# Create network security group rule to allow inbound RDP traffic from a specified IP
resource "azurerm_network_security_rule" "networkSecurityGroupRule1" {
  name                        = "AllowRDP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "0.0.0.0/0" # Enter the public IP you're connecting to your VM from
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.resourceGroup1.name}"
  network_security_group_name = "${azurerm_network_security_group.networkSecurityGroup1.name}"
}

# Create a subnet
resource "azurerm_subnet" "lanSubnet" {
  name                                                  = "LAN"
  resource_group_name                                   = "${azurerm_resource_group.resourceGroup1.name}"
  virtual_network_name                                  = "${azurerm_virtual_network.virtualNetwork1.name}"
  address_prefix                                        = "10.0.0.0/24"
  network_security_group_id                             = "${azurerm_network_security_group.networkSecurityGroup1.id}"
}

# Create a public IP
resource "azurerm_public_ip" "publicIp1" {
  name                         = "vm0001-pip"
  location                     = "West Europe"
  resource_group_name          = "${azurerm_resource_group.resourceGroup1.name}"
  public_ip_address_allocation = "static"
}

# Create a virtual network interface
resource "azurerm_network_interface" "networkInterface1" {
  name                = "vm0001-nic"
  location            = "${azurerm_resource_group.resourceGroup1.location}"
  resource_group_name = "${azurerm_resource_group.resourceGroup1.name}"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = "${azurerm_subnet.lanSubnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.publicIp1.id}"
  }
}

# Create VM
resource "azurerm_virtual_machine" "main" {
  name                  = "vm0001"
  location              = "${azurerm_resource_group.resourceGroup1.location}"
  resource_group_name   = "${azurerm_resource_group.resourceGroup1.name}"
  network_interface_ids = ["${azurerm_network_interface.networkInterface1.id}"]
  vm_size               = "Standard_A2_v2"

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-smalldisk"
    version   = "latest"
  }

  os_profile_windows_config {
    provision_vm_agent = "True"
  }

  storage_os_disk {
    name              = "vm0001-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "vm0001"
    admin_username = "MyUserName" # Enter your username in here
    admin_password = "MyPassword1" # Enter your password in here
  }
}

# Create a new disk
resource "azurerm_managed_disk" "dataDisk1" {
  name                 = "vm0001-disk2"
  location             = "${azurerm_resource_group.resourceGroup1.location}"
  resource_group_name  = "${azurerm_resource_group.resourceGroup1.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 5
}

resource "azurerm_virtual_machine_data_disk_attachment" "attachDataDisk1" {
  managed_disk_id    = "${azurerm_managed_disk.dataDisk1.id}"
  virtual_machine_id = "${azurerm_virtual_machine.main.id}"
  lun                = "10"
  caching            = "ReadWrite"
}