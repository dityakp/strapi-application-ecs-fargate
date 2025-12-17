# Strapi ECS Fargate Deployment

This project deploys a Strapi application on AWS ECS Fargate using Terraform and GitHub Actions.

**Status**: Ready for deployment with GitHub Actions CI/CD pipeline.

## Architecture

- **ECS Fargate**: Runs the containerized Strapi application with public IP
- **RDS PostgreSQL**: Database for Strapi
- **ECR**: Stores Docker images
- **CloudWatch**: Logs and monitoring

## Prerequisites

1. AWS Account with appropriate permissions
2. GitHub repository with the following secrets configured:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `DB_PASSWORD`
   - `APP_KEYS`
   - `API_TOKEN_SALT`
   - `ADMIN_JWT_SECRET`
   - `TRANSFER_TOKEN_SALT`
   - `JWT_SECRET`

## GitHub Secrets Setup

In your GitHub repository, go to Settings > Secrets and variables > Actions, and add:

```
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
DB_PASSWORD=your_secure_db_password
APP_KEYS=key1,key2,key3,key4
API_TOKEN_SALT=your_api_token_salt
ADMIN_JWT_SECRET=your_admin_jwt_secret
TRANSFER_TOKEN_SALT=your_transfer_token_salt
JWT_SECRET=your_jwt_secret
```

## Deployment Process

### Manual Deployment

1. **Initialize Terraform**:
   ```bash
   cd terraform
   terraform init
   ```

2. **Plan the deployment**:
   ```bash
   terraform plan
   ```

3. **Apply the infrastructure**:
   ```bash
   terraform apply
   ```

### Automated Deployment (GitHub Actions)

The deployment happens automatically when you push to the `main` or `master` branch:

1. **Build & Push**: Creates Docker image and pushes to ECR
2. **Infrastructure**: Updates Terraform infrastructure
3. **Deploy**: Forces ECS service update with new image

## Workflow Steps

1. Code is pushed to main/master branch
2. GitHub Actions triggers the deployment workflow
3. Docker image is built with commit SHA as tag
4. Image is pushed to ECR repository
5. Terraform applies infrastructure changes with new image URI
6. ECS service is forced to update with new deployment

## Accessing the Application

After deployment, the application will be available at the ECS task's public IP address on port 1337 (check ECS console for task details).

## Monitoring

- **CloudWatch Logs**: `/ecs/strapi-aditya`
- **Health Check**: `http://task-public-ip:1337/_health`
- **ECS Console**: Monitor service status and tasks

## Troubleshooting

### ECR Repository Not Empty Error

If you get the error about ECR repository not being empty, the Terraform configuration now includes `force_delete = true` to handle this automatically.

### Database Connection Issues

Ensure the RDS instance is in the same VPC and security groups allow communication between ECS and RDS.

### Container Health Check Failures

Check CloudWatch logs for application startup issues. The health check endpoint is `/_health`.

## Cleanup

To destroy all resources:

```bash
cd terraform
terraform destroy
```

**Note**: This will delete all data including the RDS database.