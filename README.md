# Introduction:

The module is used to deploy azure over terraform with a default setup (Infrastructure as Code).

# Exmaple Use of Modul:

    module "aad_app" {
    source = "github.com/la-cc/terraform-azure-aad-app-grafana?ref=1.0.3"

    display_name            = var.display_name
    redirect_uris           = var.redirect_uris
    app_owners              = var.app_owners
    roles                   = var.roles

    }
