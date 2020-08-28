provider "nsxt" {
  host                 = var.host
  vmc_token            = var.vmc_token
  allow_unverified_ssl = true
  enforcement_point    = "vmc-enforcementpoint"
}


resource "nsxt_policy_gateway_policy" "mgw_policy" {
  category        = "LocalGatewayRules"
  display_name    = "default"
  domain          = "mgw"

  Lifecycle {
  prevent_destroy = true
  }

  rule {
      action                = "ALLOW"
      destination_groups    = [
        "/infra/domains/mgw/groups/VCENTER",
      ]
      destinations_excluded = false
      direction             = "IN_OUT"
      disabled              = false
      display_name          = "vCenter Inbound"
      ip_version            = "IPV4_IPV6"
      logged                = false
      profiles              = []
      scope                 = [
          "/infra/labels/mgw",
      ]
      services              = ["/infra/services/HTTPS"]
      source_groups         = []
      sources_excluded      = false
  }
  rule {
      action                = "ALLOW"
      destination_groups    = []
      destinations_excluded = false
      direction             = "IN_OUT"
      disabled              = false
      display_name          = "ESXi Outbound Rule"
      ip_version            = "IPV4_IPV6"
      logged                = false
      profiles              = []
      scope                 = [
          "/infra/labels/mgw",
      ]
      services              = []
      source_groups         = [
          "/infra/domains/mgw/groups/ESXI",
      ]
      sources_excluded      = false
  }
  rule {
      action                = "ALLOW"
      destination_groups    = []
      destinations_excluded = false
      direction             = "IN_OUT"
      disabled              = false
      display_name          = "vCenter Outbound Rule"
      ip_version            = "IPV4_IPV6"
      logged                = false
      profiles              = []
      scope                 = [
          "/infra/labels/mgw",
      ]
      services              = []
      source_groups         = [
          "/infra/domains/mgw/groups/VCENTER",
      ]
      sources_excluded      = false
  }
}
