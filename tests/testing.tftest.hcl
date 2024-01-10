provider "azurerm" {
  features {}
}

run "setup" {
  module {
    source = "./tests/environment"
  }
}

run "plan" {
  command = plan

  variables {
    resource_group_name  = run.setup.resource_group_name
    virtual_network_name = run.setup.vnet_01_name
    peerings = [{
      name                         = run.setup.vnet_02_name
      remote_virtual_network_id    = run.setup.vnet_02_id
      allow_virtual_network_access = false
      allow_gateway_transit        = true
      }, {
      name                      = run.setup.vnet_03_name
      remote_virtual_network_id = run.setup.vnet_03_id
      allow_forwarded_traffic   = true
    }]
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].resource_group_name == run.setup.resource_group_name
    error_message = "The virtual network 1-2 resource group is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].virtual_network_name == run.setup.vnet_01_name
    error_message = "The virtual network 1-2 name is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].remote_virtual_network_id == run.setup.vnet_02_id
    error_message = "The remote virtual network id of virtual network 1-2 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].allow_virtual_network_access == false
    error_message = "The allow virtual network access of virtual network 1-2 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].allow_forwarded_traffic == false
    error_message = "The allow forwarded traffic of virtual network 1-2 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].allow_gateway_transit == true
    error_message = "The allow gateway transit of virtual network 1-2 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}2"].use_remote_gateways == false
    error_message = "Use remote gateways of virtual network 1-2 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].resource_group_name == run.setup.resource_group_name
    error_message = "The virtual network 1-3 resource group is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].virtual_network_name == run.setup.vnet_01_name
    error_message = "The virtual network 1-3 name is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].remote_virtual_network_id == run.setup.vnet_03_id
    error_message = "The remote virtual network id of virtual network 1-3 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].allow_virtual_network_access == true
    error_message = "The allow virtual network access of virtual network 1-3 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].allow_forwarded_traffic == true
    error_message = "The allow forwarded traffic of virtual network 1-3 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].allow_gateway_transit == false
    error_message = "The allow gateway transit of virtual network 1-3 is being modified."
  }

  assert {
    condition     = azurerm_virtual_network_peering.peering["${run.setup.resource_group_name}3"].use_remote_gateways == false
    error_message = "Use remote gateways of virtual network 1-3 is being modified."
  }
}

run "apply_1" {
  command = apply

  variables {
    resource_group_name  = run.setup.resource_group_name
    virtual_network_name = run.setup.vnet_01_name
    peerings = [{
      name                         = run.setup.vnet_02_name
      remote_virtual_network_id    = run.setup.vnet_02_id
      allow_virtual_network_access = false
      allow_gateway_transit        = true
      }, {
      name                      = run.setup.vnet_03_name
      remote_virtual_network_id = run.setup.vnet_03_id
      allow_forwarded_traffic   = true
    }]
  }
}
