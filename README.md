# Terraform-Vault Integration Project

## Overview

This project showcases the integration of HashiCorp Terraform with HashiCorp Vault, providing a streamlined approach to managing infrastructure provisioning and secrets. By combining these powerful tools, the project demonstrates secure and efficient infrastructure as code (IaC) practices.

## Features

- **AWS Infrastructure Provisioning**: Utilize Terraform to create an AWS VPC and EC2 instance.
- **HashiCorp Vault Integration**: Leverage Vault for secret management and access control.
- **AppRole Authentication**: Set up AppRole authentication in Vault for secure interactions with Terraform.
- **Fine-Grained Policies**: Implement Vault policies to control access to various paths and secrets.

## Project Structure

- **main.tf**: Terraform configuration for AWS resources and Vault integration.
- **variables.tf**: Input variables for customizing the Terraform configuration.
- **vault_policy.hcl**: Sample Vault policy defining access capabilities for Terraform.

## Getting Started

1. **AWS Infrastructure Setup**:
   - Ensure AWS credentials are configured.
   - Customize VPC settings in `variables.tf`.
   - Run `terraform init` and `terraform apply` to provision AWS resources.

2. **HashiCorp Vault Configuration**:
   - Run a Vault server at the specified address in `main.tf`.
   - Configure AppRole authentication and create an AppRole for Terraform.
   - Create a Vault policy for Terraform.

3. **Integrate Terraform with Vault**:
   - Modify the Vault provider block in `main.tf` with the correct Vault address.
   - Run `terraform init` and `terraform apply` to integrate Terraform with Vault.

## Usage

Explore and customize the project to fit your specific requirements. Use the provided scripts and configurations as a starting point for integrating Terraform and Vault into your infrastructure workflows.

## Contributing

Feel free to contribute to this project by opening issues, suggesting enhancements, or submitting pull requests. Your feedback and contributions are highly valued.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use and modify the code as needed.

Happy Terraforming!
