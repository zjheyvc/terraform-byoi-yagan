locals {
  enable_addons  = split(",", var.addons)
  enable_dex     = contains(local.enable_addons, "dex")
  enable_gangway = contains(local.enable_addons, "gangway")
  oidc_extra_args = {
    oidc-client-id      = "gangway"
    oidc-groups-claim   = "groups"
    oidc-issuer-url     = format("https://%s", var.dex_url)
    oidc-username-claim = "name"
  }
  kube_api_extra_args = local.enable_gangway ? merge(local.oidc_extra_args, var.kube_api_extra_args) : var.kube_api_extra_args
}
