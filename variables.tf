variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering."
}

variable "virtual_network_name" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network."
}

variable "peerings" {
  type = list(object({
    name                         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = optional(bool, true)
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, false)
    use_remote_gateways          = optional(bool, false)
  }))
  default     = []
  description = "List containing the blocks for the configuration of the peerings."
}
