# HCPTerraform-ProjectsFactory
Code to provision and manage HCP Terraform projects using Terraform code (IaC).

<!-- BEGIN_TF_DOCS -->
# HCP Terraform Projects Factory

Code which manages configuration and life-cycle of all the HCP Terraform
projects factory. It is designed to be used from a dedicated
API-Driven HCP Terraform workspace that would provision and manage the
configuration using Terraform code (IaC).

> Project creation and management is facilitated through a no-code
> module workflow that creates and configures the required the HCP Terraform project,
> the teams, the variable set with the variables associate with it. Each no-code
> module must be provisioned within the dedicated project to ensure proper variable
> input configuration and management.

## Permissions

### HCP Terraform Permissions

To manage the agent pool resources, provide a user token from an account with
appropriate permissions. This user should have the `Manage Projects`,
`Manage Workspaces`, `Manage Teams`, `Manage Membership`, and `Manage Organization Access`
permission. Alternatively, you can use a token from a team instead of a user token.

## Authentication

### HCP Terraform Authentication

The HCP Terraform provider requires a HCP Terraform/Terraform Enterprise API token in
order to manage resources.

There are several ways to provide the required token:

* Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
* Set the `TFE_TOKEN` environment variable. The provider can read the TFE\\_TOKEN environment variable and the token stored there
to authenticate.

## Features

* Manages configuration and life-cycle of HCP Terraform resources:
  * Project
  * Variable Set
    * Variables
  * Teams
    * Team token

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.13.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (~>0.70)

## Modules

The following Modules are called:

### <a name="module_projects_factory_team_hcp"></a> [projects\_factory\_team\_hcp](#module\_projects\_factory\_team\_hcp)

Source: app.terraform.io/benoitblais-hashicorp/team/tfe

Version: 1.0.0

## Required Inputs

The following input variables are required:

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: (Required) Name of the organization.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_project_description"></a> [project\_description](#input\_project\_description)

Description: (Optional) A description for the project.

Type: `string`

Default: `null`

### <a name="input_project_name"></a> [project\_name](#input\_project\_name)

Description: (Optional) Name of the project.

Type: `string`

Default: `"Terraform Projects Factory"`

### <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags)

Description: (Optional) A map of key-value tags to add to the project.

Type: `map(string)`

Default: `null`

## Resources

The following resources are used by this module:

- [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) (resource)
- [tfe_variable.organization](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) (resource)
- [tfe_variable.tfe_token](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) (resource)
- [tfe_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) (resource)

## Outputs

No outputs.

<!-- markdownlint-enable -->
<!-- END_TF_DOCS -->