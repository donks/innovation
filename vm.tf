//Variables
variable "vm_size"  	{default = "Basic_A1"}
variable "vm_location"  {default = "australiasoutheast"}
variable "vm_rg"  	{default = "DEMO"}

//Main Azure VM build
//Two Windows VMs
resource "azurerm_virtual_machine" "main" {
  name                  = "AUE1NPDADS00${count.index}"
  location              = "${var.vm_location}"
  resource_group_name   = "${var.vm_rg}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "${var.vm_size}"
#  count					= 2

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "AUE1NPDADS00${count.index}--osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "DELETEME"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  
  os_profile_windows_config {
    provision_vm_agent        = true
    enable_automatic_upgrades = true
  }

  tags {
    environment = "Test"
	product = "Fund Wide"
  }
}

#resource "azurerm_subnet" "internal" {
#  name                 = "internal"
#  resource_group_name  = "${var.vm_rg}"
#  virtual_network_name = "${azurerm_virtual_network.GS-AUE1-SS-VN-001.name}"
#  address_prefix       = "10.0.2.0/24"
#}


resource "azurerm_network_interface" "main" {
  name                = "AUE1NPDADS00${count.index}-nic"
  location              = "${var.vm_location}"
  resource_group_name   = "${var.vm_rg}"
#  count = 2 
  
ip_configuration {
    name                          = "configuration"
    subnet_id                     = "${azurerm_virtual_network.DEMO.id}"
    private_ip_address_allocation = "dynamic"
    //public_ip_address_id          = "${azurerm_public_ip.main.id}"
  }
}
