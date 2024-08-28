# Generate Cloud-Init user data from the template with a dynamic hostname
data "template_file" "user_data" {
  count    = var.vm_count
  template = file(var.cloud_init_template)
  vars = {
    hostname = var.vm_names[count.index]
  }
}

# Shared Cloud-Init Disk
resource "libvirt_cloudinit_disk" "commoninit" {
  count      = var.vm_count
  name       = "${var.vm_names[count.index]}-cloudinit.iso"
  pool       = var.cloudinit_pool
  user_data  = data.template_file.user_data[count.index].rendered
}

# Create VMs based on parameters
resource "libvirt_volume" "vm_disks" {
  count          = var.vm_count
  name           = "${var.vm_names[count.index]}.qcow2"
  base_volume_id = libvirt_volume.base_images[count.index % length(libvirt_volume.base_images)].id
  pool           = var.vm_pool
  format         = "qcow2"
  size           = var.disk_size  # Set disk size based on the variabl
}

resource "libvirt_domain" "vm" {
  count  = var.vm_count
  name   = var.vm_names[count.index]
  memory = var.memory_size
  vcpu   = var.vcpu_count

  # Main disk configuration
  disk {
    volume_id = libvirt_volume.vm_disks[count.index].id
  }

  # Use the shared Cloud-Init disk
  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id

  # Network interface configuration
  network_interface {
    network_name = var.network_name
  }
}