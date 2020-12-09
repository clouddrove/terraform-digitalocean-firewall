#Module      :  Firewall
#Description :  Provides a DigitalOcean Cloud Firewall resource. This can be used to create, modify, and delete Firewalls.
output "id" {
  value       = join("", digitalocean_firewall.default.*.id)
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "name" {
  value       = join("", digitalocean_firewall.default.*.name)
  description = "The name of the Firewall."
}
