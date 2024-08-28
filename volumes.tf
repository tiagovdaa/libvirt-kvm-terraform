# Create volumes for each base image
resource "libvirt_volume" "base_images" {
  count  = length(var.base_images)
  name   = var.base_images[count.index].name
  pool   = var.base_image_pool
  source = var.base_images[count.index].source
  format = "qcow2"
}
