resource "azuread_application" "main" {
  display_name            = var.display_name
  owners                  = var.app_owners
  sign_in_audience        = var.sign_in_audience
  group_membership_claims = var.group_membership_claims

  api {
    mapped_claims_enabled          = false
    requested_access_token_version = 1
  }
  dynamic "app_role" {
    for_each = var.app_roles


    content {

      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = app_role.value.enabled
      id                   = app_role.value.id
      value                = app_role.value.value

    }
  }

  dynamic "required_resource_access" {
    for_each = var.required_resource_access
    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }


  web {
    redirect_uris = var.redirect_uris

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }
  }
}

resource "azuread_service_principal" "main" {
  application_id               = azuread_application.main.application_id
  app_role_assignment_required = var.app_role_assignment_required
  owners                       = var.app_owners

  feature_tags {
    enterprise = true
    hide       = true
  }
}

resource "azuread_app_role_assignment" "main" {
  for_each = var.roles

  app_role_id         = each.value.app_role_id ##azuread_service_principal.main.app_role_ids["Admin"]
  principal_object_id = each.value.principal_object_id
  resource_object_id  = azuread_service_principal.main.object_id
}

