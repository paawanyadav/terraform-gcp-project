locals {
  subnets = {
    for x in var.subnets :
    "${x.subnet_region}/${x.subnet_name}" => x
  }
  ingress_rules = length(var.ingress_rules) > 0 ? { for rule in var.ingress_rules : rule.name => merge(rule, { direction = "INGRESS" }) } : {}
  egress_rules  = length(var.egress_rules) > 0 ? { for rule in var.egress_rules : rule.name => merge(rule, { direction = "EGRESS" }) } : {}
  rules_all     = merge(local.ingress_rules, local.egress_rules)
}