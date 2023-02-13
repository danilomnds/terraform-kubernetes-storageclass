resource "kubernetes_storage_class" "storage_class" {
  for_each = var.definition
  metadata {
    name        = lookup(each.value, "name", null)
    annotations = lookup(each.value, "annotations", null)
    labels      = lookup(each.value, "labels", null)
  }
  parameters             = lookup(each.value, "parameters", null)
  storage_provisioner    = lookup(each.value, "storage_provisioner", "file.csi.azure.com")
  reclaim_policy         = lookup(each.value, "reclaim_policy", "Delete")
  volume_binding_mode    = lookup(each.value, "volume_binding_mode", null)
  allow_volume_expansion = lookup(each.value, "allow_volume_expansion", true)
  mount_options          = lookup(each.value, "mount_options", null)

  dynamic "allowed_topologies" {
    for_each = lookup(each.value, "key", null) != null ? tolist([lookup(each.value, "key", null)]) : []
    content {
      match_label_expressions {
        key    = lookup(each.value, "key", null)
        values = lookup(each.value, "values", null)
      }
    }
  }
}