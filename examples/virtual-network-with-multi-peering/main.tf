provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "terraform-azurerm-virtual-network-peering"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "terraform-azurerm-virtual-network-peering-vnet1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "terraform-azurerm-virtual-network-peering-vnet2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network" "vnet3" {
  name                = "terraform-azurerm-virtual-network-peering-vnet3"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.3.0.0/16"]
}

module "peering1" {
  source               = "aztfm/virtual-network-peering/azurerm"
  version              = ">=1.0.0"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  peerings = [
    { name = azurerm_virtual_network.vnet2.name, remote_virtual_network_id = azurerm_virtual_network.vent2.id },
    { name = azurerm_virtual_network.vnet3.name, remote_virtual_network_id = azurerm_virtual_network.vent3.id }
  ]
}

module "peering2" {
  source               = "aztfm/virtual-network-peering/azurerm"
  version              = ">=1.0.0"
  resource_group_name  = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  peerings = [
    { name = azurerm_virtual_network.vnet1.name, remote_virtual_network_id = azurerm_virtual_network.vnet1.id },
    { name = azurerm_virtual_network.vnet3.name, remote_virtual_network_id = azurerm_virtual_network.vnet3.id }
  ]
}

module "peering3" {
  source               = "aztfm/virtual-network-peering/azurerm"
  version              = ">=1.0.0"
  resource_group_name  = azurerm_virtual_network.vnet3.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet3.name
  peerings = [
    { name = azurerm_virtual_network.vnet1.name, remote_virtual_network_id = azurerm_virtual_network.vnet1.id },
    { name = azurerm_virtual_network.vnet2.name, remote_virtual_network_id = azurerm_virtual_network.vnet2.id }
  ]
}
