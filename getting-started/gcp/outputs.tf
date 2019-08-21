# Output definitions go here

output "ip" {
  value = google_compute_address.vm_static_ip.address
}

output "vpc_network_subnets_ips" {
  value = module.network.subnets_ips
}
