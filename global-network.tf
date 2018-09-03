##
## Create global services networking resources
##

## Create global resource group to contain resources 
resource "azurerm_resource_group" "GS-AUE1-SS-RG-001" {
        name = "GS-AUE1-SS-RG-001"
        location = "australiasoutheast"
                  tags {
                      environment = "production"
                      owner = "TS"
					  costCentre = "TS"
					  product = "Fund_Wide"
                    }
}

##
## Create global services virtual network 
##

resource "azurerm_virtual_network" "GS-AUE1-SS-VN-001" {
  name                = "GS-AUE1-SS-VN-001"
  address_space       = ["10.180.240.0/20"]
  location            = "${azurerm_resource_group.GS-AUE1-SS-RG-001.location}"
  resource_group_name = "${azurerm_resource_group.GS-AUE1-SS-RG-001.name}"
 
tags {
    environment = "Production"
    owner = "TS"
	costCentre = "TS"
	product = "Fund_Wide"
  }
}

##
## Create Subnets
##
resource "azurerm_subnet" "GS-AUE1-SS-SN-ACC-001" {
name           		= "GS-AUE1-SS-SN-ACC-001"
address_prefix 		= "10.180.240.0/24"
network_security_group_id 		= "${azurerm_network_security_group.GS-AUE1-SS-NSG-001.id}"
resource_group_name 	= "${azurerm_resource_group.GS-AUE1-SS-RG-001.name}"
virtual_network_name	="${azurerm_virtual_network.GS-AUE1-SS-VN-001.name}"
}

resource "azurerm_subnet" "GS-AUE1-SS-SN-MGT-001" {
name           		= "GS-AUE1-SS-SN-MGT-001"
address_prefix 		= "10.180.241.0/24"
network_security_group_id 		= "${azurerm_network_security_group.GS-AUE1-SS-NSG-002.id}"
resource_group_name 	= "${azurerm_resource_group.GS-AUE1-SS-RG-001.name}"
virtual_network_name	="${azurerm_virtual_network.GS-AUE1-SS-VN-001.name}"
} 

##
## Create blank NW security groups for subnets
## Application security groups used to secure application flows
##
resource "azurerm_network_security_group" "GS-AUE1-SS-NSG-001" {
  name                = "GS-AUE1-SS-NSG-001"
  location            = "${azurerm_resource_group.GS-AUE1-SS-RG-001.location}"
  resource_group_name = "${azurerm_resource_group.GS-AUE1-SS-RG-001.name}"
 
tags {
    environment = "Test"
    owner = "TS"
	costCentre = "TS"
	product = "Fund Wide"
  }
}
 
resource "azurerm_network_security_group" "GS-AUE1-SS-NSG-002" {
  name                = "GS-AUE1-SS-NSG-002"
  location            = "${azurerm_resource_group.GS-AUE1-SS-RG-001.location}"
  resource_group_name = "${azurerm_resource_group.GS-AUE1-SS-RG-001.name}"
 
tags {
    environment = "Test"
    owner = "BOB"
	costCentre = "TS"
	product = "Fund Wide"
  }
}

