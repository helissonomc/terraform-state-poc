# Terraform State POC

This repository demonstrates Terraform state management with AWS backend and automated CI/CD workflows.

## CI/CD Workflow

The repository includes a GitHub Actions workflow (`.github/workflows/terraform.yml`) that automates Terraform operations:

- **Terraform Plan**: Runs on pull requests to preview infrastructure changes
- **Terraform Apply**: Automatically applies changes when code is merged to main

### AWS Credentials Configuration

The workflow uses `aws-actions/configure-aws-credentials@v4` with static credentials. **Important**: This action requires proper `permissions` blocks to function correctly.

#### Required Permissions

Both jobs include `permissions` blocks to ensure the AWS credentials action can access secrets:

```yaml
permissions:
  contents: read
  pull-requests: write  # For terraform-plan job only
```

#### Required Secrets

Configure the following secrets in your GitHub repository settings:

- `AWS_ACCESS_KEY_ID`: Your AWS access key ID
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret access key

### Usage

The workflow uses [just](https://github.com/casey/just) as a command runner. See `main/justfile` for available commands.

## Project Structure

- `main/`: Main Terraform configuration
  - `backend.tf`: S3 backend configuration
  - `provider.tf`: AWS provider configuration
  - `justfile`: Command runner configuration
