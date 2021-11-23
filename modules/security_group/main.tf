# TIP: Worth checking: 
# https://github.com/terraform-aws-modules/terraform-aws-security-group/blob/master/rules.tf
# For predefined ports for various services

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks                   = var.ingress_cidr
  egress_cidr_blocks                    = var.egress_cidr
  ingress_rules                         = var.ingress_rules
  egress_rules                          = var.egress_rules
  egress_prefix_list_ids                = var.egress_prefix_list_ids
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  egress_with_cidr_blocks               = var.egress_with_cidr_blocks
  tags                                  = var.tags
  egress_with_source_security_group_id  = var.egress_with_source_security_group_id
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
}
