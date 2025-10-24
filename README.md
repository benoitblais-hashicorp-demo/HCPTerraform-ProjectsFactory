# HCPTerraform-ProjectsFactory
Code to provision and manage HCP Terraform projects using Terraform code (IaC).

<!-- BEGIN_TF_DOCS -->


## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.13.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (~>0.70)

## Modules

No modules.

## Required Inputs

The following input variables are required:

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: (Required) Name of the organization.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_github_teams"></a> [github\_teams](#input\_github\_teams)

Description:   (Optional) The github\_teams block supports the following:  
    name        : (Required) The name of the team.  
    description : (Optional) A description of the team.  
    permission  : (Optional) The permissions of team members regarding the repository. Must be one of `pull`, `triage`, `push`, `maintain`, `admin` or the name of an existing custom repository role within the organisation.

Type:

```hcl
list(object({
    name        = string
    description = optional(string)
    permission  = optional(string, "pull")
  }))
```

Default:

```json
[
  {
    "description": "This group grant admin access to the Terraform Modules repository.",
    "name": "Terraform-Modules-Owners",
    "permission": "admin"
  },
  {
    "description": "This group grant write access to the Terraform Modules repository.",
    "name": "Terraform-Modules-Contributors",
    "permission": "push"
  }
]
```

### <a name="input_github_template"></a> [github\_template](#input\_github\_template)

Description: (Optional) The GitHub repository to use as a template when creating new repositories. The repository must be a template repository. If not provided, the default template provided by the module will be used.

Type: `string`

Default: `null`

### <a name="input_module_name"></a> [module\_name](#input\_module\_name)

Description: (Optional) Name of the terraform module used by the modules factory.

Type: `string`

Default: `"terraform-tfe-modulesfactory"`

### <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name)

Description: (Optional) Name of the OAuth client.

Type: `string`

Default: `"GitHub"`

### <a name="input_project_description"></a> [project\_description](#input\_project\_description)

Description: (Optional) A description for the project.

Type: `string`

Default: `null`

### <a name="input_project_name"></a> [project\_name](#input\_project\_name)

Description: (Optional) Name of the project.

Type: `string`

Default: `"Terraform Modules Factory"`

### <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags)

Description: (Optional) A map of key-value tags to add to the project.

Type: `map(string)`

Default: `null`

## Resources

The following resources are used by this module:

- [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) (resource)
- [tfe_variable_set.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable_set) (resource)

## Outputs

No outputs.

<!-- markdownlint-enable -->
<!-- END_TF_DOCS -->