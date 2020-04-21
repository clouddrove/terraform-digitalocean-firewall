## Managed By : CloudDrove
##Description : This Script is used to create firewall.
## Copyright @ CloudDrove. All Right Reserved.


#Module      : Label
#Description : This terraform module is designed to generate consistent label names and
#              tags for resources. You can use terraform-labels to implement a strict
#              naming convention.
module "labels" {
  source = "git::https://github.com/clouddrove/terraform-digitalocean-labels.git"

  name        = var.name
  application = var.application
  environment = var.environment
  label_order = var.label_order
}

locals {
  firewall_count = var.enable_firewall == true ? 1 : 0
}

#Module      :  Firewall
#Description :  Provides a DigitalOcean Cloud Firewall resource. This can be used to create, modify, and delete Firewalls.
resource "digitalocean_firewall" "default" {
  count = local.firewall_count

  name        = module.labels.id
  droplet_ids = var.droplet_ids

  dynamic "inbound_rule" {
    iterator = port
    for_each = var.allowed_ports
    content {
      port_range       = port.value
      protocol         = var.protocol
      source_addresses = var.allowed_ip
    }
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  tags = [
    module.labels.name,
    module.labels.application,
    module.labels.environment,
    module.labels.createdby,
    module.labels.managedby
  ]
}
