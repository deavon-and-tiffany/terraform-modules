resource "kubernetes_priority_class" "low" {
  metadata {
    name = "low"
  }
  description = <<EOT
    Pods with this priority class will be the most likely to be evicted and rescheduled during a scale event.
  EOT

  value          = 50
  global_default = false
}
