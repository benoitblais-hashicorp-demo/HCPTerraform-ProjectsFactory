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
* Set the `TFE_TOKEN` environment variable. The provider can read the TFE\_TOKEN environment variable and the token stored there
to authenticate.

## Features

* Manages configuration and life-cycle of HCP Terraform resources:
  * Project
  * Variable Set
    * Variables
  * Teams
    * Team token
