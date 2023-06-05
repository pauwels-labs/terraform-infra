# output "install_path" {
#   value = [for i in range(local.cluster_count) : data.flux_install.this[i].path]
# }

# output "install_content" {
#   value = data.kubectl_file_documents.install_content
# }

# output "sync_path" {
#   value = [for i in range(local.cluster_count) : data.flux_sync.this[i].path]
# }

# output "sync_content" {
#   value = data.kubectl_file_documents.sync_content
# }

# output "kustomize_path" {
#   value = [for i in range(local.cluster_count) : data.flux_sync.this[i].kustomize_path]
# }

# output "kustomize_content" {
#   value = data.kubectl_file_documents.kustomize_content
# }
