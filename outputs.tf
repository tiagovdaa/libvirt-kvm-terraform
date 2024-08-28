# Output the IP addresses of the VMs
output "vm_ips" {
  value = [for i in libvirt_domain.vm : try(i.network_interface.0.addresses[0], "IP not assigned yet")]
}
