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

resource "azurerm_subnet" "tf-az-vnet-peering-vnet1" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-1.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-1.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_virtual_network" "tf-az-vnet-peering-2" {
  name                = "terraform-azurerm-virtual-network-peering-vnet2"
  resource_group_name = azurerm_resource_group.tf-az-vnet-peering.name
  location            = azurerm_resource_group.tf-az-vnet-peering.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_public_ip" "tf-az-vnet-peering" {
  name                = "terraform-azurerm-virtual-network-peering-vpn-pip"
  resource_group_name = azurerm_resource_group.tf-az-vnet-peering.name
  location            = azurerm_resource_group.tf-az-vnet-peering.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_virtual_network_gateway" "tf-az-vnet-peering" {
  name                = "terraform-azurerm-virtual-network-peering-vpn"
  resource_group_name = azurerm_virtual_network.tf-az-vnet-peering-1.resource_group_name
  location            = azurerm_virtual_network.tf-az-vnet-peering-1.location
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "Basic"
  generation          = "Generation1"
  ip_configuration {
    name                          = "vnetGatewayConfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.tf-az-vnet-peering-vnet1.id
    public_ip_address_id          = azurerm_public_ip.tf-az-vnet-peering.id
  }
}

module "tf-az-vnet-peering-1" {
  depends_on           = [azurerm_virtual_network_gateway.tf-az-vnet-peering]
  source               = "./terraform-azurerm-virtual-network-peering"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-1.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-1.name
  peerings = [
    {
      name                      = azurerm_virtual_network.tf-az-vnet-peering-2.name
      remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-2.id
      allow_gateway_transit     = true
    }
  ]
}

module "tf-az-vnet-peering-2" {
  source               = "./terraform-azurerm-virtual-network-peering"
  resource_group_name  = azurerm_virtual_network.tf-az-vnet-peering-2.resource_group_name
  virtual_network_name = azurerm_virtual_network.tf-az-vnet-peering-2.name
  peerings = [
    {
      name                      = module.tf-az-vnet-peering-1.peerings[azurerm_virtual_network.tf-az-vnet-peering-2.name].virtual_network_name
      remote_virtual_network_id = azurerm_virtual_network.tf-az-vnet-peering-1.id
      use_remote_gateways       = true
    }
  ]
}
