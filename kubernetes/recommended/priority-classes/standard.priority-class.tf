resource "kubernetes_priority_class" "standard" {
  metadata {
    name = "standard"
  }
  description = <<EOT
    Pods with this priority class may be evicted and rescheduled during a scale event.
  EOT

  value          = 5000
  global_default = true
}
