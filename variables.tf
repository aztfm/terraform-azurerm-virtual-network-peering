variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering."
}

variable "virtual_network_name" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network."
}

variable "peerings" {
  type        = list(map(string))
  description = "List containing the blocks for the configuration of the peerings."
  /*
  peerings = [
    {
      name                         = ""
      remote_virtual_networks_id   = ""
      allow_virtual_network_access = ""
      allow_forwarded_traffic      = ""
      allow_gateway_transit        = ""
      use_remote_gateways          = ""
    }
  ]
  */
}
