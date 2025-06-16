# Azure Virtual Network Peering - Terraform Module

[devcontainer]: https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/aztfm/terraform-azurerm-virtual-network-peering
[registry]: https://registry.terraform.io/modules/aztfm/virtual-network-peering/azurerm/
[releases]: https://github.com/aztfm/terraform-azurerm-virtual-network-peering/releases

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)](https://github.com/pre-commit/pre-commit)
[![Terraform Registry](https://img.shields.io/badge/terraform-registry-blueviolet?logo=terraform&logoColor=white)][registry]
[![Dev Container](https://img.shields.io/badge/devcontainer-VSCode-blue?logo=linuxcontainers)][devcontainer]
[![License](https://img.shields.io/github/license/aztfm/terraform-azurerm-virtual-network-peering)](LICENSE)
[![Last release](https://img.shields.io/github/v/release/aztfm/terraform-azurerm-virtual-network-peering)][releases]

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/aztfm/terraform-azurerm-virtual-network-peering?quickstart=1)

## Version compatibility

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 3.x.x       | >= 1.9.x          | >= 2.0.0        |
| >= 2.x.x       | >= 1.3.x          | >= 2.0.0        |
| >= 1.x.x       | >= 0.13.x         | >= 2.0.0        |

<!-- BEGIN_TF_DOCS -->
## :arrow_forward: Parameters

The following parameters are supported:

| Name | Description | Type | Default | Required |
| ---- | ----------- | :--: | :-----: | :------: |
|resource\_group\_name|The name of the resource group in which to create the virtual network peering.|`string`|n/a|yes|
|virtual\_network\_name|The full Azure resource ID of the remote virtual network.|`string`|n/a|yes|
|peerings|List containing the blocks for the configuration of the peerings.|`list(object({}))`|`[]`|no|

The `peerings` supports the following:

| Name | Description | Type | Default | Required |
| ---- | ------------| :--: | :-----: | :------: |
|name|The name of the virtual network peering.|`string`|n/a|yes|
|remote\_virtual\_network\_id|The full Azure resource ID of the remote virtual network.|`string`|n/a|yes|
|allow\_virtual\_network\_access|Controls if the VMs in the remote virtual network can access VMs in the local virtual network.|`bool`|`true`|no|
|allow\_forwarded\_traffic|Controls if forwarded traffic from VMs in the remote virtual network is allowed.|`bool`|`false`|no|
|allow\_gateway\_transit|Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.|`bool`|`false`|no|
|use\_remote\_gateways|Controls if remote gateways can be used on the local virtual network.|`bool`|`false`|no|

## :arrow_backward: Outputs

The following outputs are exported:

| Name | Description | Sensitive |
| ---- | ------------| :-------: |
|peerings|Blocks containing configuration of each peering.|no|
<!-- END_TF_DOCS -->
