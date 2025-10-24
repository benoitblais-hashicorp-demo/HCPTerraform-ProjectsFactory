variable "organization_name" {
  description = "(Required) Name of the organization."
  type        = string
  nullable    = false
}

variable "github_teams" {
  description = <<EOT
  (Optional) The github_teams block supports the following:
    name        : (Required) The name of the team.
    description : (Optional) A description of the team.
    permission  : (Optional) The permissions of team members regarding the repository. Must be one of `pull`, `triage`, `push`, `maintain`, `admin` or the name of an existing custom repository role within the organisation.
  EOT
  type = list(object({
    name        = string
    description = optional(string)
    permission  = optional(string, "pull")
  }))
  nullable = false
  default = [{
    name        = "Terraform-Projects-Owners"
    description = "This group grant admin access to the Terraform Projects repository."
    permission  = "admin"
    },
    {
      name        = "Terraform-Projects-Contributors"
      description = "This group grant write access to the Terraform Projects repository."
      permission  = "push"
  }]
}

variable "github_template" {
  description = "(Optional) The GitHub repository to use as a template when creating new repositories. The repository must be a template repository. If not provided, the default template provided by the Project will be used."
  type        = string
  nullable    = true
  default     = null
}

variable "Project_name" {
  description = "(Optional) Name of the terraform Project used by the Projects factory."
  type        = string
  default     = "terraform-tfe-Projectsfactory"
}

variable "oauth_client_name" {
  description = "(Optional) Name of the OAuth client."
  type        = string
  nullable    = false
  default     = "GitHub"
}

variable "project_description" {
  description = "(Optional) A description for the project."
  type        = string
  nullable    = true
  default     = null
}

variable "project_name" {
  description = "(Optional) Name of the project."
  type        = string
  nullable    = true
  default     = "Terraform Projects Factory"
}

variable "project_tags" {
  description = "(Optional) A map of key-value tags to add to the project."
  type        = map(string)
  nullable    = true
  default     = null
}
