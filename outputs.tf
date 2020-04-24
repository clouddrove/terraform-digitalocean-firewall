#Module      : SSH KEY
#Description : Provides a DigitalOcean SSH key resource to allow you to manage SSH keys for Droplet access.
output "id" {
  value       = join("", digitalocean_firewall.default.*.id)
  description = "A unique ID that can be used to identify and reference a Firewall."
}

output "name" {
  value       = join("", digitalocean_firewall.default.*.name)
  description = "The name of the Firewall."
}
