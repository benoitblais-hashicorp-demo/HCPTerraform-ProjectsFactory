# The following code block is used to create and manage the project where all the workspaces related to the projects will be stored.

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

# The following module blocks are used to create and manage the HCP Terraform teams required by the `projects factory`.

module "projects_factory_team_hcp" {
  source       = "app.terraform.io/benoitblais-hashicorp/team/tfe"
  version      = "1.0.0"
  count        = length(tfe_project.this) > 0 ? 1 : 0
  name         = lower(replace("${tfe_project.this[0].name}-hcp", "/\\W|_|\\s/", "-"))
  organization = var.organization_name
  organization_access = {
    manage_membership          = true
    manage_organization_access = true
    manage_projects            = true
    manage_teams               = true
    manage_workspaces          = true
  }
  token = true
}

# The following resource blocks are used to create variables that will be stored into the variable set previously created.

resource "tfe_variable" "tfe_token" {
  count           = length(module.projects_factory_team_hcp) > 0 ? 1 : 0
  key             = "TFE_TOKEN"
  value           = module.projects_factory_team_hcp[0].token
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.this[0].id
}

resource "tfe_variable" "organization" {
  count           = length(tfe_variable_set.this) > 0 ? 1 : 0
  key             = "organization"
  value           = var.organization_name
  category        = "terraform"
  description     = "(Optional) A description for the project."
  variable_set_id = tfe_variable_set.this[0].id
}
