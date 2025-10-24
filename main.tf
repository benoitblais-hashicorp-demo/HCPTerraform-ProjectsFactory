# The following code block is used to create and manage the project where all the workspaces related to the published modules will be stored.

resource "tfe_project" "this" {
  count        = var.project_name != null ? 1 : 0
  name         = var.project_name
  organization = var.organization_name
  description  = var.project_description
  tags = merge(var.project_tags, {
    managed_by_terraform = "true"
  })
}

# The following code block is used to create and manage the variable set at the project level that will own the variables required by the child workspaces.

# NOTE: How can we configure the scope

resource "tfe_variable_set" "this" {
  count             = length(tfe_project.this) > 0 ? 1 : 0
  name              = lower(replace("${tfe_project.this[0].name}-hcp", "/\\W|_|\\s/", "-"))
  description       = "Variable set for project \"${tfe_project.this[0].name}\"."
  organization      = var.organization_name
  parent_project_id = tfe_project.this[0].id
}

# # The following module blocks are used to create and manage the HCP Terraform teams required by the `modules factory`.

# module "modules_factory_team_hcp" {
#   source       = "./modules/tfe_team"
#   count        = length(tfe_project.this) > 0 ? 1 : 0
#   name         = lower(replace("${tfe_project.this[0].name}-hcp", "/\\W|_|\\s/", "-"))
#   organization = var.organization_name
#   organization_access = {
#     manage_modules = true
#   }
#   token = true
# }

# module "modules_factory_team_git" {
#   source       = "./modules/tfe_team"
#   count        = length(tfe_project.this) > 0 ? 1 : 0
#   name         = lower(replace("${tfe_project.this[0].name}-git", "/\\W|_|\\s/", "-"))
#   organization = var.organization_name
#   organization_access = {
#     manage_modules = true
#   }
#   token = true
# }

# # The following resource blocks are used to create variables that will be stored into the variable set previously created.

# resource "tfe_variable" "tfe_token" {
#   count           = length(module.modules_factory_team_hcp) > 0 ? 1 : 0
#   key             = "TFE_TOKEN"
#   value           = module.modules_factory_team_hcp[0].token
#   category        = "env"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "github_app_id" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "GITHUB_APP_ID"
#   value           = var.app_id
#   category        = "env"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "github_app_installation_id" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "GITHUB_APP_INSTALLATION_ID"
#   value           = var.app_installation_id
#   category        = "env"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "github_app_pem_file" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "GITHUB_APP_PEM_FILE"
#   value           = var.app_pem_file
#   category        = "env"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "github_owner" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "GITHUB_OWNER"
#   value           = var.github_organization
#   category        = "env"
#   sensitive       = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "oauth_client_name" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "oauth_client_name"
#   value           = var.oauth_client_name
#   category        = "terraform"
#   description     = "(Optional) Name of the OAuth client."
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "organization" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "organization"
#   value           = var.organization_name
#   category        = "terraform"
#   description     = "(Optional) A description for the project."
#   variable_set_id = tfe_variable_set.this[0].id
# }

# locals {
#   github_teams = [for team in var.github_teams :
#     {
#       name       = team.name
#       permission = team.permission
#     }
#   ]
#   github_teams_formated = [for team in local.github_teams :
#     "  {\n    name = \"${team.name}\",\n    permission = \"${team.permission}\"\n  }"
#   ]
#   github_teams_string = "[\n${join(",\n", local.github_teams_formated)}\n]"
# }

# resource "tfe_variable" "github_teams" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "github_teams"
#   value           = local.github_teams_string
#   category        = "terraform"
#   description     = "(Optional) The github_teams block supports the following:\nname: (Required) The name of the team.\npermission: (Optional) The permissions of team members regarding the repository. Must be one of `pull`, `triage`, `push`, `maintain`, `admin` or the name of an existing custom repository role within the organisation."
#   hcl             = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "template" {
#   count           = length(tfe_variable_set.this) > 0 && var.github_template != null ? 1 : 0
#   key             = "template"
#   value           = "{\n  owner = \"${var.github_organization}\",\n  repository = \"${var.github_template}\"\n}"
#   category        = "terraform"
#   description     = "(Optional) The template block supports the following:\nowner: (Required) The GitHub organization or user the template repository is owned by.\nrepository: (Required) The name of the template repository."
#   hcl             = true
#   variable_set_id = tfe_variable_set.this[0].id
# }

# resource "tfe_variable" "git_tfe_token" {
#   count           = length(tfe_variable_set.this) > 0 ? 1 : 0
#   key             = "tfe_token"
#   value           = var.organization_name
#   category        = "terraform"
#   description     = "(Optional) The TFE_TOKEN secret value to be created in the GitHub repository to allow the module to publish itself into the private registry."
#   variable_set_id = tfe_variable_set.this[0].id
# }
