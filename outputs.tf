# Output configuration for Azure File Backup Automation Infrastructure

output "resource_group_name" {
  description = "The name of the created resource group."
  value       = azurerm_resource_group.backup.name
}

output "storage_account_name" {
  description = "The globally unique name of the storage account."
  value       = azurerm_storage_account.backup.name
}

output "storage_container_name" {
  description = "The name of the backup storage container."
  value       = azurerm_storage_container.backup_files.name
}

output "logic_app_name" {
  description = "The name of the automated Logic App workflow."
  value       = azurerm_logic_app_workflow.backup.name
}

output "logic_app_principal_id" {
  description = "The principal ID of the System-Assigned Managed Identity for RBAC."
  value       = try(azurerm_logic_app_workflow.backup.identity[0].principal_id, null)
}

output "logic_app_tenant_id" {
  description = "The tenant ID of the System-Assigned Managed Identity."
  value       = try(azurerm_logic_app_workflow.backup.identity[0].tenant_id, null)
}
