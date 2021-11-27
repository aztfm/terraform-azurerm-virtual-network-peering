resource "azurerm_resource_group" "rg" {
  name     = "resource-group"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "virtual-network-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "virtual-network-2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_public_ip" "pip" {
  name                = "public-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_virtual_network_gateway" "vgw" {
  name                = "virtual-network-gateway"
  resource_group_name = azurerm_virtual_network.vnet1.resource_group_name
  location            = azurerm_virtual_network.vnet1.location
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "Basic"
  generation          = "Generation1"
  ip_configuration {
    name                          = "vnetGatewayConfig"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

module "peering1" {
  depends_on           = [azurerm_virtual_network_gateway.vgw]
  source               = "aztfm/virtual-network-peering/azurerm"
  version              = ">=1.0.0"
  resource_group_name  = azurerm_virtual_network.vnet1.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  peerings = [
    {
      name                      = azurerm_virtual_network.vnet2.name
      remote_virtual_network_id = azurerm_virtual_network.vnet2.id
      allow_gateway_transit     = true
    }
  ]
}

module "peering2" {
  source               = "aztfm/virtual-network-peering/azurerm"
  version              = ">=1.0.0"
  resource_group_name  = azurerm_virtual_network.vnet2.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  peerings = [
    {
      name                      = module.peering1.peerings[azurerm_virtual_network.vnet2.name].virtual_network_name
      remote_virtual_network_id = azurerm_virtual_network.vnet1.id
      use_remote_gateways       = true
    }
  ]
}
