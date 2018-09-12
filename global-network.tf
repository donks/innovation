##
## Create global services networking resources
##

## Create global resource group to contain resources 
resource "azurerm_resource_group" "DEMO" {
        name = "Demo"
        location = "australiasoutheast"
                  tags {
                      environment = "demo"
                      owner = "TS"
		      CostCentre = "TS"
		      creator = "Terraform"
                    }
}

##
## Create global services virtual network 
##

resource "azurerm_virtual_network" "DEMO" {
  name                = "DEMO"
  address_space       = ["10.180.240.0/20"]
  location            = "${azurerm_resource_group.DEMO.location}"
  resource_group_name = "${azurerm_resource_group.DEMO.name}"
 
tags {
    environment = "DEMO"
    owner = "TS"
	costCentre = "TS"
	product = "Fund_Wide"
	creator = "Terraform"
  }
}

##
## Create Subnets
##
resource "azurerm_subnet" "DEMO-SN-001" {
name           		= "DEMO-SN-001"
address_prefix 		= "10.180.240.0/24"
network_security_group_id 	= "${azurerm_network_security_group.DEMO-NSG-001.id}"
resource_group_name 	= "${azurerm_resource_group.DEMO.name}"
virtual_network_name	="${azurerm_virtual_network.DEMO.name}"
}

resource "azurerm_subnet" "DEMO-SN-002" {
name           		= "DEMO-SN-002"
address_prefix 		= "10.180.241.0/24"
network_security_group_id 		= "${azurerm_network_security_group.DEMO-NSG-002.id}"
resource_group_name 	= "${azurerm_resource_group.DEMO.name}"
virtual_network_name	="${azurerm_virtual_network.DEMO.name}"
} 
##
## Create blank NW security groups for subnets
## Application security groups used to secure application flows
##
resource "azurerm_network_security_group" "DEMO-NSG-001" {
  name                = "DEMO-NSG-001"
  location            = "${azurerm_resource_group.DEMO.location}"
  resource_group_name = "${azurerm_resource_group.DEMO.name}"
 
tags {
    environment = "DEMO"
    owner = "TS"
	costCentre = "TS"
	creator = "Terraform"
  }
}
 
resource "azurerm_network_security_group" "DEMO-NSG-002" {
  name                = "DEMO-NSG-002"
  location            = "${azurerm_resource_group.DEMO.location}"
  resource_group_name = "${azurerm_resource_group.DEMO.name}"
 
tags {
    environment = "Test"
    owner = "BOB"
	costCentre = "TS"
	creator = "Fund Wide"
  }
}

