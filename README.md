# Introduction:

The module is used to deploy azure app-registration for grafana sso over terraform with a default setup (Infrastructure as Code).

> **_NOTE:_** The required providers, providers configuration and terraform version are maintained in the user's configuration and are not maintained in the modules themselves.

# Example Use of Module:

    module "aad_app" {
    source = "github.com/la-cc/terraform-azure-aad-app-grafana?ref=1.0.0"

    display_name            = var.display_name
    redirect_uris           = var.redirect_uris
    app_owners              = var.app_owners
    roles                   = var.roles

    }
