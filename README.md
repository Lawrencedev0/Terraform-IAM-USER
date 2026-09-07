# Terraform IAM User, Group & Role Project

Ye Terraform project AWS par ek **IAM User**, **IAM Group**, aur **IAM Role** create karta hai, aur inko zaroori permissions (S3 Full Access + EC2 Full Access) assign karta hai.

## 📌 Project Overview

Is project mein 3 alag IAM identities banti hain:

1. **IAM User** (`waqas-user`) — Ek client ke liye AWS identity
2. **IAM Group** (`rana-group`) — User ko is group mein add kiya jata hai
3. **IAM Role** (`client-role`) — EC2 service ke liye assume-able role

### Permissions
Group aur Role dono ko ye 2 AWS Managed Policies attach ki gayi hain:
- `AmazonS3FullAccess` — S3 bucket create/upload/manage karne ke liye
- `AmazonEC2FullAccess` — EC2 instance create/manage karne ke liye

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
IAM User (waqas-user)
      │
      ▼ (membership)
IAM Group (rana-group) ──► S3 Full Access Policy
                          └─► EC2 Full Access Policy

IAM Role (client-role, assumed by EC2 service)
      ├─► S3 Full Access Policy
      └─► EC2 Full Access Policy
```

- User group ka member banta hai (`aws_iam_user_group_membership`) → group ki dono policies use kar sakta hai
- Role independent hai, sirf EC2 service isko assume kar sakti hai (trust policy ke through)

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
Confirmation ke liye `yes` type karein.

### 5. Destroy resources (jab zaroorat na ho)
```bash
terraform destroy
```

## 🔧 Variables

| Variable Name    | Description           | Default Value  |
|-------------------|------------------------|-----------------|
| `aws_region`      | AWS region              | `us-east-1`     |
| `iam_user_name`   | IAM User ka naam        | `waqas-user`   |
| `iam_group_name`  | IAM Group ka naam       | `rana-group`  |
| `iam_role_name`   | IAM Role ka naam        | `client-role`   |

Variables ko `variables.tf` mein edit karke ya `terraform apply -var="iam_user_name=new-name"` se override kiya ja sakta hai.

## 📤 Outputs

| Output Name       | Description                  |
|---------------------|-------------------------------|
| `iam_user_name`   | Created IAM user ka naam       |
| `iam_user_arn`    | Created IAM user ka ARN        |
| `iam_group_name`  | Created IAM group ka naam      |
| `iam_role_name`   | Created IAM role ka naam       |
| `iam_role_arn`    | Created IAM role ka ARN        |

## ⚠️ Notes

- User ke liye programmatic access (Access Key/Secret Key) is project mein nahi banaya gaya — sirf identity aur permissions set hain.
- Role sirf **EC2 service** ke liye assume-able hai (trust policy mein `ec2.amazonaws.com` set hai).
- Dono full-access policies **AWS Managed Policies** hain — production environment mein least-privilege custom policies use karna better practice hai.

## 👤 Author

**CHUKWU CHIBUIKE DANIEL**
DevOps & Cloud Engineer
GitHub: [Lawrencedev0](https://github.com/Lawrencedev0)