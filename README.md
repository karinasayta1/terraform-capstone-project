# TerraWeek Capstone – Multi-Environment Infrastructure with Terraform Workspaces and Modules

## Overview

This project is the final capstone of **TerraWeek (Day 67) of my DailyDevOpsChallemge**. It demonstrates how to build production-style AWS infrastructure using **Terraform Modules** and **Terraform Workspaces**.

A single Terraform codebase is used to provision three isolated environments:

* Development (`dev`)
* Staging (`staging`)
* Production (`prod`)

Each environment has its own:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Security Group
* EC2 Instance
* Independent Terraform State

The project follows Terraform best practices including modular design, reusable code, environment isolation, tagging, and workspace-based deployments.

---

# Project Structure

```
terraweek-capstone/
├── main.tf
├── providers.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── dev.tfvars
├── staging.tfvars
├── prod.tfvars
├── .gitignore
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2-instance/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── terraform.tfstate.d/
```

---

# Architecture

Each workspace provisions the following infrastructure:

```
Terraform Workspace
        │
        ▼
      AWS VPC
        │
        ▼
   Public Subnet
        │
        ▼
Internet Gateway
        │
        ▼
 Route Table
        │
        ▼
Security Group
        │
        ▼
   EC2 Instance
```

Each workspace creates completely isolated infrastructure.

---

# Prerequisites

Before running this project ensure you have:

* Terraform >= 1.5
* AWS CLI v2
* IAM User with permissions to create:

  * VPC
  * Subnets
  * Internet Gateway
  * Route Tables
  * Security Groups
  * EC2 Instances
* Configured AWS CLI credentials

Verify installation:

```bash
terraform version
aws --version
aws sts get-caller-identity
```

---

# Clone the Repository

```bash
git clone <your-repository-url>

cd terraweek-capstone
```

---

# Initialize Terraform

```bash
terraform init
```

This command:

* Downloads the AWS provider
* Initializes Terraform
* Installs local modules

---

# Terraform Workspaces

View current workspace

```bash
terraform workspace show
```

Create workspaces

```bash
terraform workspace new dev

terraform workspace new staging

terraform workspace new prod
```

List workspaces

```bash
terraform workspace list
```

Switch workspace

```bash
terraform workspace select dev

terraform workspace select staging

terraform workspace select prod
```

---

# Environment Configuration

## Development

```
VPC CIDR      : 10.0.0.0/16
Subnet CIDR   : 10.0.1.0/24
Instance Type : t3.micro (or supported type)
Ports         : 22,80
```

---

## Staging

```
VPC CIDR      : 10.1.0.0/16
Subnet CIDR   : 10.1.1.0/24
Instance Type : t3.micro / t2.small
Ports         : 22,80,443
```

---

## Production

```
VPC CIDR      : 10.2.0.0/16
Subnet CIDR   : 10.2.1.0/24
Instance Type : t3.micro / t3.small
Ports         : 80,443
```

> **Note:** If your AWS account restricts certain EC2 instance types, you can use `t3.micro` for all environments while keeping different CIDR ranges and security group rules.

---

# Deploy Development Environment

```bash
terraform workspace select dev

terraform plan -var-file="dev.tfvars"

terraform apply -var-file="dev.tfvars"
```

---

# Deploy Staging Environment

```bash
terraform workspace select staging

terraform plan -var-file="staging.tfvars"

terraform apply -var-file="staging.tfvars"
```

---

# Deploy Production Environment

```bash
terraform workspace select prod

terraform plan -var-file="prod.tfvars"

terraform apply -var-file="prod.tfvars"
```

---

# Verify Outputs

For each workspace:

```bash
terraform output
```

Example:

```
instance_id

public_ip

security_group_id

subnet_id

vpc_id

workspace
```

---

# Validate Configuration

Format files

```bash
terraform fmt -recursive
```

Validate configuration

```bash
terraform validate
```

---

# Verify in AWS Console

Confirm:

* Three VPCs
* Three Public Subnets
* Three Security Groups
* Three EC2 Instances
* Different Name tags
* Different CIDR ranges
* Separate workspace resources

---

# Destroy Infrastructure

Destroy Production

```bash
terraform workspace select prod

terraform destroy -var-file="prod.tfvars"
```

Destroy Staging

```bash
terraform workspace select staging

terraform destroy -var-file="staging.tfvars"
```

Destroy Development

```bash
terraform workspace select dev

terraform destroy -var-file="dev.tfvars"
```

---

# Delete Workspaces

Switch back to default

```bash
terraform workspace select default
```

Delete

```bash
terraform workspace delete dev

terraform workspace delete staging

terraform workspace delete prod
```

---

# Terraform Commands Reference

Initialize

```bash
terraform init
```

Format

```bash
terraform fmt
```

Validate

```bash
terraform validate
```

Plan

```bash
terraform plan
```

Apply

```bash
terraform apply
```

Destroy

```bash
terraform destroy
```

Show Outputs

```bash
terraform output
```

Current Workspace

```bash
terraform workspace show
```

List Workspaces

```bash
terraform workspace list
```

Switch Workspace

```bash
terraform workspace select <workspace-name>
```

---

# Terraform Best Practices

* Use reusable modules.
* Separate providers, variables, outputs, and locals into dedicated files.
* Keep one responsibility per module.
* Never hardcode configuration values.
* Use `.tfvars` for environment-specific settings.
* Use Terraform Workspaces for environment isolation.
* Tag every AWS resource.
* Keep Terraform state secure.
* Always run `terraform fmt`.
* Always run `terraform validate`.
* Review `terraform plan` before `terraform apply`.
* Destroy unused infrastructure to avoid unnecessary AWS charges.

---

# Common Issues

## Module not installed

Run:

```bash
terraform init
```

---

## Invalid EC2 Instance Type

Use a supported instance type for your AWS account.

Example:

```
t3.micro
```

---

## State Lock Error

Wait for the lock to be released or investigate stale locks before retrying.

---

## Provider Errors

Verify AWS credentials:

```bash
aws sts get-caller-identity
```

---

# Learning Outcomes

After completing this project you will understand:

* Infrastructure as Code
* Terraform configuration
* AWS Provider
* Variables
* Outputs
* Locals
* Data Sources
* Terraform State
* Remote Backend concepts
* Custom Modules
* Module Reusability
* Terraform Workspaces
* Multi-environment Deployments
* Infrastructure Isolation
* AWS Networking Basics
* EC2 Provisioning
* Security Groups
* Terraform Best Practices

---

# TerraWeek Learning Journey

| Day | Topics                                                                   |
| --- | ------------------------------------------------------------------------ |
| 61  | IaC, HCL, init, plan, apply, destroy, state                              |
| 62  | Providers, resources, lifecycle, dependencies                            |
| 63  | Variables, outputs, locals, data sources                                 |
| 64  | Remote backend, state locking, drift detection                           |
| 65  | Custom modules, registry modules                                         |
| 66  | Amazon EKS with Terraform Modules                                        |
| 67  | Terraform Workspaces, Multi-Environment Infrastructure, Capstone Project |

---

# Author

**Karina Sayta**

Completed as part of the **#90DaysOfDevOps – TerraWeek Challenge**.

**Happy Learning! 🚀**
