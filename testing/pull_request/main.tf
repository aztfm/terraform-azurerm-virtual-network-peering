resource "azurerm_resource_group" "rg" {
  name     = uuid()
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "${azurerm_resource_group.rg.name}1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "${azurerm_resource_group.rg.name}2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network" "vnet3" {
  name                = "${azurerm_resource_group.rg.name}3"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.3.0.0/16"]
}

module "peering1" {
  source               = "./module"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  peerings = [
    { name = "virtualNetwork2", remote_virtual_network_id = azurerm_virtual_network.vnet2.id },
    { name = "virtualNetwork3", remote_virtual_network_id = azurerm_virtual_network.vnet3.id }
  ]
}

module "peering2" {
  source               = "./module"
  resource_group_name  = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  peerings = [
    { name = "virtualNetwork1", remote_virtual_network_id = azurerm_virtual_network.vnet1.id },
    { name = "virtualNetwork3", remote_virtual_network_id = azurerm_virtual_network.vnet3.id }
  ]
}

module "peering3" {
  source               = "./module"
  resource_group_name  = azurerm_virtual_network.vnet3.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  peerings = [
    { name = "virtualNetwork1", remote_virtual_network_id = azurerm_virtual_network.vnet1.id },
    { name = "virtualNetwork2", remote_virtual_network_id = azurerm_virtual_network.vnet2.id }
  ]
}
