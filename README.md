# Terraform IAM User, Group & Role Project

Terraform project AWS LAW **IAM User**, **IAM Group**, LAW **IAM Role** create LAW1, LAW permissions (S3 Full Access + EC2 Full Access) assign LAW.

## 📌 Project Overview

This project provisions three distinct AWS IAM identities:

1. **IAM User** (`LAW-user`) — An AWS identity created for the client.
2. **IAM Group** (`LAW-group`) — The IAM user is added to this group to inherit its assigned permissions.
3. **IAM Role** (`client-role`) — An IAM role that can be assumed by the EC2 service.

### Permissions
Group and Role AWS Managed Policies attach have been done:
- `AmazonS3FullAccess` — Provides permissions to create and manage Amazon S3 buckets and objects.
- `AmazonEC2FullAccess` — Provides permissions to create, configure, and manage Amazon EC2.

## 📂 Project Structure

```
.
├── provider.tf      # AWS provider configuration
├── variables.tf     # Input variables
├── main.tf          # Core resources (user, group, role, policies)
├── outputs.tf        # Output values
└── README.md         # Project documentation
```

## 🔗 Resource Relationships

```
IAM User (LAW-user)
      │
      ▼ (membership)
IAM Group (LAW-group) ──► S3 Full Access Policy
                          └─► EC2 Full Access Policy

IAM Role (client-role, assumed by EC2 service)
      ├─► S3 Full Access Policy
      └─► EC2 Full Access Policy
```

- The IAM user becomes a member of the user group (aws_iam_user_group_membership) and can therefore use the permissions granted by both policies attached to the group.
- IAM role is independent of the user group and can only be assumed by the EC2 service, as defined by its trust policy.

## ⚙️ Prerequisites

- Terraform installed (`>= 1.0`)
- AWS CLI configured with valid credentials (`aws configure`)
- AWS account with IAM permissions to create users/groups/roles

## 🚀 Usage

### 1. Clone / Navigate to project folder
```bash
cd iam-user-group-project
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the plan
```bash
terraform plan
```

### 4. Apply the configuration
```bash
terraform apply
```
Enter yes to confirm.

### 5.Destroy the provisioned resources when they are no longer required
```bash
terraform destroy
```

## 🔧 Variables

| Variable Name    | Description           | Default Value  |
|-------------------|------------------------|-----------------|
| `aws_region`      | AWS region              | `us-east-1`     |
| `iam_user_name`   | IAM User                | `LAW-user`   |
| `iam_group_name`  | IAM Group               | `LAW-group`  |
| `iam_role_name`   | IAM Role                | `client-role`   |

Variables can be modified in variables.tf or overridden using the terraform apply -var="iam_user_name=new-name"

## 📤 Outputs

| Output Name       | Description                  |
|---------------------|-------------------------------|
| `iam_user_name`   | Created IAM user               |
| `iam_user_arn`    | Created IAM user ARN           |
| `iam_group_name`  | Created IAM group              |
| `iam_role_name`   | Created IAM role               |
| `iam_role_arn`    | Created IAM role  ARN          |

## ⚠️ Notes

- Programmatic access (Access Key/Secret Key) has not been created for the IAM user in this project; only the user's identity and permissions have been configured.
- The IAM role can only be assumed by the EC2 service, as specified in the trust policy using ec2.amazonaws.com.
- Both full-access policies are AWS Managed Policies. In a production environment, it is recommended to follow the principle of least privilege by using custom policies with
  only the permissions required.

## 👤 Author

**CHUKWU CHIBUIKE DANIEL**
DevOps & Cloud Engineer
GitHub: [Lawrencedev0](https://github.com/Lawrencedev0)
