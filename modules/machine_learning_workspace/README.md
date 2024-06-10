# Machine Learning Workspace

Module to create a machine learning workspace and other related compute resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.105.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.105.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_application_insights.ml_workspace_app_insights](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_machine_learning_compute_cluster.compute_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_cluster) | resource |
| [azurerm_machine_learning_compute_instance.compute_instance](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_compute_instance) | resource |
| [azurerm_machine_learning_workspace.ml_workspace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/machine_learning_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assigned_user_object_id"></a> [assigned\_user\_object\_id](#input\_assigned\_user\_object\_id) | Users AAD Object Id. | `string` | n/a | yes |
| <a name="input_assigned_user_tenant_id"></a> [assigned\_user\_tenant\_id](#input\_assigned\_user\_tenant\_id) | Users AAD Tenant Id. | `string` | n/a | yes |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | The ID of key vault associated with this Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which the Cognitive Service Account is created. <br>Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | The ID of the Storage Account associated with this Machine Learning Workspace. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ml_workspace_discovery_url"></a> [ml\_workspace\_discovery\_url](#output\_ml\_workspace\_discovery\_url) | The url for the discovery service to identify regional endpoints for <br>machine learning experimentation services. |
| <a name="output_ml_workspace_id"></a> [ml\_workspace\_id](#output\_ml\_workspace\_id) | The ID of the Machine Learning Workspace. |
| <a name="output_ml_workspace_workspace_id"></a> [ml\_workspace\_workspace\_id](#output\_ml\_workspace\_workspace\_id) | The immutable id associated with this workspace. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->