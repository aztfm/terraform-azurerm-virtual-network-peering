provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf-az-vnet-peering" {
  name     = "terraform-azurerm-virtual-network-peering"
  location = "West Europe"
}

resource "azurerm_virtual_network" "tf-az-vnet-peering-1" {
  name                = "terraform-azurerm-virtual-network-peering-vnet1"
  resource_group_name = azurerm_resource_group.tf-az-vnet-peering.name
  location            = azurerm_resource_group.tf-az-vnet-peering.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network" "tf-az-vnet-peering-2" {
  name                = "terraform-azurerm-virtual-network-peering-vnet2"
  resource_group_name = azurerm_resource_group.tf-az-vnet-peering.name
  location            = azurerm_resource_group.tf-az-vnet-peering.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_virtual_network" "tf-az-vnet-peering-3" {
  name                = "terraform-azurerm-virtual-network-peering-vnet3"
  resource_group_name = azurerm_resource_group.tf-az-vnet-peering.name
  location            = azurerm_resource_group.tf-az-vnet-peering.location
  address_space       = ["10.3.0.0/16"]
}

module "tf-az-vnet-peering-1" {
  source               = "./terraform-azurerm-virtual-network-peering"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-1.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-1.name
  peerings = [
    { name = azurerm_virtual_network.tf-az-vnet-peering-2.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-2.id },
    { name = azurerm_virtual_network.tf-az-vnet-peering-3.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-3.id }
  ]
}

module "tf-az-vnet-peering-2" {
  source               = "./terraform-azurerm-virtual-network-peering"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-2.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-2.name
  peerings = [
    { name = azurerm_virtual_network.tf-az-vnet-peering-1.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-1.id },
    { name = azurerm_virtual_network.tf-az-vnet-peering-3.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-3.id }
  ]
}

module "tf-az-vnet-peering-3" {
  source               = "./terraform-azurerm-virtual-network-peering"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-3.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-3.name
  peerings = [
    { name = azurerm_virtual_network.tf-az-vnet-peering-1.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-1.id },
    { name = azurerm_virtual_network.tf-az-vnet-peering-2.name, remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-2.id }
  ]
}
