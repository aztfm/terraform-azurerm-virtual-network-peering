resource "azurerm_resource_group" "rg" {
  name     = local.workspace_id
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet_01" {
  name                = "${local.workspace_id}1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "vnet_02" {
  name                = "${local.workspace_id}2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.2.0/24"]
}

resource "azurerm_virtual_network" "vnet_03" {
  name                = "${local.workspace_id}3"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.3.0/24"]
}
