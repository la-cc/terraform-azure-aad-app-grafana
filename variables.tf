variable "display_name" {
  type        = string
  description = "The display name for the application."
}


variable "redirect_uris" {

  type        = list(string)
  description = " A set of URLs where user tokens are sent for sign-in, or the redirect URIs where OAuth 2.0 authorization codes and access tokens are sent. Must be a valid https or ms-appx-web URL."

}

variable "app_owners" {

  type        = list(string)
  description = "A set of object IDs of principals that will be granted ownership of the application. Supported object types are users or service principals. By default, no owners are assigned"
}

variable "group_membership_claims" {

  type        = list(string)
  default     = ["ApplicationGroup", "SecurityGroup"]
  description = "Configures the groups claim issued in a user or OAuth 2.0 access token that the app expects. Possible values are None, SecurityGroup, DirectoryRole, ApplicationGroup or All"
}

variable "sign_in_audience" {
  type        = string
  default     = "AzureADMyOrg"
  description = "The Microsoft account types that are supported for the current application. Must be one of AzureADMyOrg, AzureADMultipleOrgs, AzureADandPersonalMicrosoftAccount or PersonalMicrosoftAccount. Defaults to AzureADMyOrg"
}
variable "app_role_assignment_required" {
  type        = bool
  default     = false
  description = "Whether this service principal requires an app role assignment to a user or group before Azure AD will issue a user or access token to the application. Defaults to false."
}

variable "required_resource_access" {
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))

  default = [
    {

      resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

      resource_access = [
        {
          id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" #used.read
          type = "Scope"
        },

        {
          id   = "37f7f235-527c-4136-accd-4a02d197296e" #openid
          type = "Scope"
        },

        {
          id   = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0" #email
          type = "Scope"
        }

      ]
    }
  ]

  description = <<-EOT
    List of required_resource_access blocks, each including a list of resource_access blocks.

    Example:

    [
      {
        resource_app_id = "00000002-0000-0000-c000-000000000000"

        resource_access = [
          {
            id   = "824c81eb-e3f8-4ee6-8f6d-de7f50d565b7"
            type = "Role"
          },
          {
            id   = "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175"
            type = "Role"
          }
        ]
      }
    ]

    Explanation:

    resource_app_id: The unique identifier for the resource that the application requires access to. This should be equal to the appId declared on the target resource application.
    id: The unique identifier for one of the OAuth2Permission or AppRole instances that the resource application exposes.
    type: Specifies whether the id property references an OAuth2Permission or an AppRole. Possible values are Scope or Role.
  EOT
}

variable "roles" {

  type = map(object({

    app_role_id         = string
    principal_object_id = string

  }))

  default = {}

  description = <<-EOT
    Map of object to assign roles like admin, viewer and editor to objects like user, sp, aad-groups.

    Example:

    default = {

    "admin" = {
      app_role_id = "Admin"
      principal_object_id = "32d05457-daec-4bda-9c3d-32cc083c0468"
    }

  EOT

}

variable "app_roles" {
  type = map(object({
    allowed_member_types = list(string)
    description          = string
    display_name         = string
    enabled              = bool
    id                   = string
    value                = string


  }))
  default = {

    "grafana_viewer" = {
      allowed_member_types = ["User"]
      description          = "Grafana read only Users"
      display_name         = "Grafana Viewer"
      enabled              = true
      id                   = "5ece0e92-30f6-4c31-8c94-e7195c20f668"
      value                = "Viewer"
    },

    "grafana_editor" = {
      allowed_member_types = ["User"]
      description          = "Grafana Editor Users"
      display_name         = "Grafana Editor"
      enabled              = true
      id                   = "2b2d3ad4-1c78-45db-a077-909f755c36aa"
      value                = "Editor"
    },

    "grafana_admin" = {
      allowed_member_types = ["User"]
      description          = "Grafana admin Userss"
      display_name         = "Grafana Admin"
      enabled              = true
      id                   = "e15be93c-edc1-4b89-ad19-c5f143de6ebd"
      value                = "Admin"
    }

  }

  description = <<-EOT
    List of app_roles to configure app_role in for a aad application.

    Example:

    default = {

      "grafana_viewer" = {
        allowed_member_types = ["User"]
        description          = "Grafana read only Users"
        display_name         = "Grafana Viewer"
        enabled              = true
        id                   = "5ece0e92-30f6-4c31-8c94-e7195c20f668"
        value                = "Viewer"
      },

      "grafana_editor" = {
        allowed_member_types = ["User"]
        description          = "Grafana Editor Users"
        display_name         = "Grafana Editor"
        enabled              = true
        id                   = "2b2d3ad4-1c78-45db-a077-909f755c36aa"
        value                = "Editor"
      }

    }

   Explanation:
   A collection of app_role blocks as documented below. For more information see official documentation on Application Roles.

  EOT
}