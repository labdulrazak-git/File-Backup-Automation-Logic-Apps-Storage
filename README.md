Azure Simple File Backup Automation (Terraform)A minimalist, serverless, and cost-optimized infrastructure blueprint to automate business file backups. This solution replaces risky, manual workflows with an automated Azure Logic App that securely schedules and drops files into a private Azure Blob Storage container.[Local/Network Files] ──> [Logic App (Daily Trigger)] ──> [Blob Storage (Cool Tier)]
🛠️ PrerequisitesAzure CLI (v2.37.0+) & authenticated session (az login).Terraform CLI (v1.0+).CLI Extension: az extension add --name logic🚀 Quick Start DeploymentRun these sequential steps from the terraform/ directory to stand up the environment:Bash# 1. Initialize providers
terraform init

# 2. Review planned resources
terraform plan -var="resource_group_name=rg-backup-demo"

# 3. Apply infrastructure
terraform apply -var="resource_group_name=rg-backup-demo" --auto-approve
⚙️ Configuration ReferenceVariableTypeDefaultDescriptionresource_group_namestringRequiredTarget Resource Group name.locationstring"eastus"Target Azure Region.environmentstring"demo"Prefix for resource naming tags.backup_schedule_hournumber2Execution hour (0-23) for the daily backup.🛡️ Well-Architected Design Highlights🔒 Zero Hardcoded Secrets: Uses an Entra ID System-Assigned Managed Identity for secure, passwordless authentication between the Logic App and Storage.💰 Cost Optimization: Utilizes the Storage Cool Access Tier to minimize monthly data holding costs, paired with a Logic App Consumption Plan (pay-per-execution, $0 standing idle fees).🚫 High Isolation: Public anonymous blob access (allow_blob_public_access) is explicitly disabled; all data transport requires TLS 1.2 over HTTPS.🩺 Verification & CleanupPost-Deployment Health CheckBash# Confirm the Logic App is deployed and enabled
az logic workflow show --resource-group rg-backup-demo --name la-backup-demo --query "{State:state}"

# Verify public anonymous access is blocked on the storage account
az storage account show --name stbackupdemo --resource-group rg-backup-demo --query "allowBlobPublicAccess"
Tear Down InfrastructureBashterraform destroy -var="resource_group_name=rg-backup-demo"
