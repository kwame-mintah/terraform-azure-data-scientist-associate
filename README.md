# Terraform Azure Data Scientist Associate

The main purpose of this repository is to terraform all the resources needed for [Exam DP-100: Designing and Implementing a Data Science Solution on Azure](https://learn.microsoft.com/en-us/credentials/certifications/azure-data-scientist/?practice-assessment-type=certification).

The end goal is to easily deploy all the resources needed for the [self-paced learning](https://learn.microsoft.com/en-gb/plans/e21nup286eomwx?source=docs) modules. 
I have created resources following the instructions in the lab exercises to reflect using the Azure Portal UI. Please note your your mileage may (or might) vary, 
as these resources were deployed using my personal account which has no restrictions.

## Development

### Dependencies

- [terraform](https://www.terraform.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [pre-commit](https://pre-commit.com/)
- [terraform-docs](https://terraform-docs.io/) this is required for `terraform_docs` hooks

## Prerequisites

1. Have a [Azure Portal](https://portal.azure.com/) account. 
2. You will need to create a Service Principal with a Client Secret [follow instructions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-in-the-azure-portal).
3. Other permissions needed are Azure Key Vault and Azure Storage for the Terraform client.

## Information on HashiCorp BSL License Change

Due to the HashiCorp BSL license change, restricting Terraform to the latest open source version (`1.5.7`). 
Will create a new project template using OpenTofu. To learn more, see the official [OpenTofu website](https://opentofu.org/) 
and [project status](https://github.com/opentofu/opentofu/blob/main/WEEKLY_UPDATES.md).

## Usage

1. Navigate to the environment you would like to deploy,
2. Plan your changes with `terragrunt plan` to see what changes will be made,
3. If you're happy with the changes `terragrunt apply`.

> **IMPORTANT**
> 
>Please note that `.tfstate` files are stored locally on your machine as no backend has been specified. If you would like to properly version control your state files, it is possible to use an azure storage account to store these files. 
> This will ensure anyone else other than you running a plan or apply will be using the same state file.
> 

## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:
```
<!-- {BEGINNING|END} OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, <= 1.5.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.105.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.105.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ml_workspace"></a> [ml\_workspace](#module\_ml\_workspace) | ./modules/machine_learning_workspace | n/a |
| <a name="module_ml_workspace_storage"></a> [ml\_workspace\_storage](#module\_ml\_workspace\_storage) | ./modules/storage_account | n/a |
| <a name="module_tfstate_storage"></a> [tfstate\_storage](#module\_tfstate\_storage) | ./modules/storage_account | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | The Client ID which should be used. This can also be sourced <br>from the ARM\_CLIENT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | The Client Secret which should be used. This can also be sourced <br>from the ARM\_CLIENT\_SECRET Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | The Subscription ID which should be used. This can also be sourced <br>from the ARM\_SUBSCRIPTION\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_tenant_id"></a> [arm\_tenant\_id](#input\_arm\_tenant\_id) | The Tenant ID which should be used. This can also be sourced <br>from the ARM\_TENANT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_cloud_enviornment"></a> [cloud\_enviornment](#input\_cloud\_enviornment) | The Cloud Environment which should be used. Possible values are public,<br>`usgovernment`, `german`, and `china`. Defaults to `public`. This can also be <br>sourced from the ARM\_ENVIRONMENT Environment Variable. | `string` | `"public"` | no |
| <a name="input_create_tfstate_store"></a> [create\_tfstate\_store](#input\_create\_tfstate\_store) | Create a storage account to remotely store tfstate for the project. **NOTE**: requires<br>local `.tfstate` to be migrated to remote, after storeage account has been created. | `bool` | `false` | no |
| <a name="input_env_prefix"></a> [env\_prefix](#input\_env\_prefix) | The prefix added to resources in the environment. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. <br>Changing this forces a new Resource Group to be created. | `string` | `"West Europe"` | no |
| <a name="input_personal_ip_address"></a> [personal\_ip\_address](#input\_personal\_ip\_address) | Add your client IP address to the storage account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_principal_client_id"></a> [service\_principal\_client\_id](#output\_service\_principal\_client\_id) | The principal being used to apply terraform changes <br>for this subscription. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID used for this subscription. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
