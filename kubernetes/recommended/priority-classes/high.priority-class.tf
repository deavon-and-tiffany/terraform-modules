resource "kubernetes_priority_class" "high" {
  metadata {
    name = "high"
  }
  description = <<EOT
    Pods with this priority class will be the least likely to be evicted and rescheduled during a scale event.
  EOT

  value          = 10000
  global_default = false
}
