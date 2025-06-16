## 2.0.0 (January 10, 2024)

BREAKING CHANGES:

* dependencies: updating to `v1.3.0` minimum of `terraform`.

ENHANCEMENTS:

* Internal changes that change the way data is received by child parameters, but do not change the behavior of the module.
* the `allow_virtual_network_access` parameter property now defaults to `true`.
* the `allow_forwarded_traffic` parameter property now defaults to `false`.
* the `allow_gateway_transit` parameter property now defaults to `false`.
* the `use_remote_gateways` parameter property now defaults to `false`.

## 1.0.1 (November 27, 2021)

ENHANCEMENTS:

* Internal changes that do not modify the operation of the module.

## 1.0.0 (November 06, 2020)

FEATURES:

* **New Parameter:** `resource_group_name`
* **New Parameter:** `virtual_network_name`
* **New Parameter:** `peerings`
* **New Parameter:** `peerings.remote_virtual_networks_id`
* **New Parameter:** `peerings.allow_virtual_network_access`
* **New Parameter:** `peerings.allow_forwarded_traffic`
* **New Parameter:** `peerings.allow_gateway_transit`
* **New Parameter:** `peerings.use_remote_gateways`
