# CloudTrail Management Infrastructure

This repository manages AWS CloudTrail configuration for audit logging and compliance tracking.

## 📋 Project Overview

- **Purpose**: Set up and manage AWS CloudTrail for centralized audit logging
- **Region**: ap-south-1 (Asia Pacific - Mumbai)
- **Current Workflow**: CLI-Driven (moving to VCS-Driven)
- **State Management**: Terraform Cloud
- **Organization**: lincy21_terraform

## 🏗️ Project Structure

```
cloudtrail-management/
├── README.md                          # This file
├── TERRAFORM_WORKFLOWS.md             # Workflow documentation
├── .gitignore                         # Git ignore rules
├── modules/
│   └── cloudtrail/
│       ├── main.tf                   # CloudTrail resource definitions
│       ├── variables.tf              # Input variables
│       └── outputs.tf                # Output values
└── envs/
    └── dev/
        ├── backend.tf                # Terraform Cloud configuration
        ├── main.tf                   # Environment-specific configuration
        └── terraform.tfvars          # Environment variables (not in git)
```

## 🚀 Quick Start

### Prerequisites

```bash
# Ensure you have:
- Terraform >= 1.4.0
- AWS CLI configured
- Doormat for AWS credential management
- GitHub access
- Terraform Cloud account (lincy21_terraform organization)
```

### Current Setup (CLI-Driven Workflow)

```bash
# 1. Export AWS credentials
doormat aws export --account aws_lincy.bainiwal_test

# 2. Navigate to dev environment
cd envs/dev

# 3. Initialize Terraform (connects to Terraform Cloud)
terraform init

# 4. Review changes
terraform plan

# 5. Apply changes
terraform apply
```

## 📊 CloudTrail Resources

### Main Components

| Resource | Name | Purpose |
|----------|------|---------|
| S3 Bucket | `lincy-cloudtrail-audit-v2` | Store CloudTrail logs |
| CloudTrail | `lincy-management-audit-trail` | Audit logging trail |

### Tags Applied

```terraform
Name        = "cloudtrail-management"
Environment = "Dev"
```

## 🔐 AWS Credentials

The project uses Doormat for credential rotation:

```bash
# Export credentials before running Terraform
doormat aws export --account aws_lincy.bainiwal_test

# For Terraform Cloud execution
doormat aws tf-push variable-set --account aws_lincy.bainiwal_test --id varset-<id>
```

## 🔄 Workflows

This project supports three Terraform workflow methods:

### 1. Local Workflow
Run Terraform commands on your local machine with local state.

### 2. CLI-Driven Workflow ✅ (Current)
Run Terraform commands locally, but execution happens in Terraform Cloud with remote state.

**Current Workspace**: `cloudtrail-cli-dev`

### 3. VCS-Driven Workflow ⭐ (Recommended)
Push code to GitHub, Terraform Cloud automatically plans and applies.

**Recommended Workspace**: `cloudtrail-vcs-dev`

For detailed workflow documentation, see [TERRAFORM_WORKFLOWS.md](./TERRAFORM_WORKFLOWS.md)

## 📝 Common Tasks

### Plan Infrastructure Changes

```bash
cd envs/dev
terraform plan
```

### Apply Infrastructure Changes

```bash
cd envs/dev
terraform apply
```

### View Current State

```bash
# View in Terraform Cloud UI
# Organization: lincy21_terraform
# Workspace: cloudtrail-cli-dev

# Or via terraform
terraform state list
terraform state show module.cloudtrail_auditor.aws_cloudtrail.this
```

### Destroy Infrastructure

```bash
cd envs/dev
terraform destroy
```

## 🔄 VCS-Driven Workflow (Production Setup)

### Setup Steps

1. **Connect GitHub to Terraform Cloud** (if not already done)
   ```bash
   # In Terraform Cloud organization settings
   # VCS Providers → GitHub → Connect
   ```

2. **Create VCS-Driven Workspace**
   - Workspace name: `cloudtrail-vcs-dev`

3. **Configure VCS Settings**
   - Repository: `LincyBainiwal/terraform-infra`
   - Branch: `main`
   - Working Directory: `cloudtrail-management/envs/dev`
   - Auto Apply: Unchecked (manual approval)

4. **Push AWS Credentials**
   ```bash
   doormat aws tf-push variable-set \
     --account aws_lincy.bainiwal_test \
     --workspace cloudtrail-vcs-dev \
     --id varset-<id>
   ```

5. **Make and Push Changes**
   ```bash
   # Edit files
   vim envs/dev/main.tf
   
   # Commit and push
   git add envs/dev/main.tf
   git commit -m "Update CloudTrail configuration"
   git push origin main
   
   # Terraform Cloud automatically triggers plan
   # Review in web UI and click "Confirm & Apply"
   ```

## 📋 Environment Variables

### Development Environment (`envs/dev/`)

Key variables defined in `terraform.tfvars`:
- `trail_name`: CloudTrail trail identifier
- `bucket_name`: S3 bucket for CloudTrail logs
- Environment tags (Name, Environment)

**Note**: `terraform.tfvars` is not committed to Git (contains sensitive defaults)

## 🔍 Monitoring

### CloudTrail Logs
CloudTrail logs are stored in S3: `s3://lincy-cloudtrail-audit-v2/AWSLogs/`

### Terraform Cloud Console
Monitor all infrastructure changes:
- Organization: `lincy21_terraform`
- Current Workspace: `cloudtrail-cli-dev`
- Future Workspace: `cloudtrail-vcs-dev`

## 🛡️ Best Practices

1. **Always review terraform plan output** before applying
2. **Use meaningful commit messages** for all Git commits
3. **Tag all resources** for cost tracking and organization
4. **Store sensitive data** in Terraform Cloud variables, not in Git
5. **Use pull requests** for code review (VCS-Driven workflow)
6. **Rotate AWS credentials** regularly via Doormat
7. **Monitor CloudTrail logs** in S3 for audit purposes

## ⚠️ Important Notes

- State file is managed in Terraform Cloud (not local)
- CloudTrail is an AWS compliance requirement - changes should be reviewed
- S3 bucket contains audit logs - do not delete without archiving
- AWS credentials expire - refresh regularly using Doormat

## 🔗 Related Projects

- `s3-app-assets`: Similar VCS-Driven workflow setup
- `ec2-web-server`: EC2 infrastructure with Terraform
- `rds-mysql`: RDS database infrastructure

## 📚 References

- [Terraform Cloud Documentation](https://www.terraform.io/cloud-docs)
- [CloudTrail Documentation](https://docs.aws.amazon.com/cloudtrail/)
- [Terraform Workflows Guide](./TERRAFORM_WORKFLOWS.md)

## 🤝 Contributing

When making changes:

1. Create a feature branch
2. Make changes to `.tf` files
3. Run `terraform plan` to review
4. Commit with descriptive message
5. Push to GitHub
6. Create pull request (for VCS-Driven workflow)
7. Review in Terraform Cloud
8. Approve and apply

## 🆘 Troubleshooting

### Terraform Init Fails

```bash
# Clear cache and retry
rm -rf envs/dev/.terraform
terraform init
```

### AWS Credentials Expired

```bash
# Refresh Doormat credentials

# Re-export for Terraform Cloud

```

### State Lock Issues

```bash
# Force unlock (use with caution)
terraform force-unlock <LOCK_ID>
```

## 📝 Last Updated

- Created: 2026-02-26
- Last Modified: 2026-02-26
- Workflow Status: **CLI-Driven (ready for VCS migration)**

