# Azure Virtual Network Peering - Terraform Module
![Testing module](https://github.com/aztfm/terraform-azurerm-virtual-network-peering/workflows/Testing%20module/badge.svg?branch=main)
[![TF Registry](https://img.shields.io/badge/terraform-registry-blueviolet.svg)](https://registry.terraform.io/modules/aztfm/virtual-network-peering/azurerm/)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-virtual-network-peering)

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 1.x.x       | >= 0.13.x         | >= 2.0.0        |

## Parameters

The following parameters are supported:

| Name                   | Description                                                                    |        Type         | Default | Required |
| ---------------------- | ------------------------------------------------------------------------------ | :-----------------: | :-----: | :------: |
| resource\_group\_name  | The name of the resource group in which to create the virtual network peering. |      `string`       |   n/a   |   yes    |
| virtual\_network\_name | The full Azure resource ID of the remote virtual network.                      |      `string`       |   n/a   |   yes    |
| peerings               | List containing the blocks for the configuration of the peerings.              | `list(map(string))` |   n/a   |   yes    |

##
The peerings supports the following:

| Name                            | Description                                                                                          |   Type   | Default | Required |
| ------------------------------- | ---------------------------------------------------------------------------------------------------- | :------: | :-----: | :------: |
| name                            | The name of the virtual network peering.                                                             | `string` |   n/a   |   yes    |
| remote\_virtual\_networks\_id   | The full Azure resource ID of the remote virtual network.                                            | `string` |   n/a   |   yes    |
| allow\_virtual\_network\_access | Controls if the VMs in the remote virtual network can access VMs in the local virtual network.       |  `bool`  | `true`  |    no    |
| allow\_forwarded\_traffic       | Controls if forwarded traffic from VMs in the remote virtual network is allowed.                     |  `bool`  | `true`  |    no    |
| allow\_gateway\_transit         | Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network. |  `bool`  | `false` |    no    |
| use\_remote\_gateways           | Controls if remote gateways can be used on the local virtual network.                                |  `bool`  | `false` |    no    |

## Outputs

The following outputs are exported:

| Name     | Description                                      |
| -------- | ------------------------------------------------ |
| peerings | Blocks containing configuration of each peering. |
