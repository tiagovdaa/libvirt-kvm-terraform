# Number of machines to create
variable "vm_count" {
  type        = number
  description = "Number of VMs to create"
}

# VM names
variable "vm_names" {
  type        = list(string)
  description = "List of VM names"
}

# Base images
variable "base_images" {
  type = list(object({
    name   = string
    source = string
  }))
  description = "List of base images to be downloaded, each with a name and source URL."
}

# Storage pool for base images
variable "base_image_pool" {
  type        = string
  description = "Storage pool for the base images."
}

# Storage pool for VM disks
variable "vm_pool" {
  type        = string
  description = "Storage pool for the VM disks."
}

# Storage pool for Cloud-Init ISO
variable "cloudinit_pool" {
  type        = string
  description = "Storage pool for the Cloud-Init disk."
}

# VM memory size (in MB)
variable "memory_size" {
  type        = number
  description = "Amount of memory for the VMs in MB"
}

# VM vCPU count
variable "vcpu_count" {
  type        = number
  description = "Number of vCPUs for the VMs"
}

# Cloud-init template file path
variable "cloud_init_template" {
  type        = string
  description = "Path to the Cloud-Init template file"
}

# Network name
variable "network_name" {
  type        = string
  description = "Name of the network to attach the VMs to"
}

# VM disk size in MB
variable "disk_size" {
  type        = number
  description = "Size of the VM disk in MB"
}