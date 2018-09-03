provider "azurerm" {
	version = "~> 1.13"
	subscription_id 		= "${var.AZURE_SUBSCRIPTION_ID}"
	tenant_id       		= "${var.AZURE_TENANT_ID}"
	client_id       		= "${var.AZURE_CLIENT_ID}"
	client_secret   		= "${var.AZURE_CLIENT_SECRET}"
}