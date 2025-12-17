# Quick Setup Instructions

## 1. Fix the ECR Repository Issue

The Terraform configuration has been updated with `force_delete = true` for the ECR repository. Run:

```bash
cd terraform
terraform apply
```

This will resolve the "ECR Repository not empty" error.

## 2. Generate Secrets

Run the secret generation script:

```bash
npm run generate:secrets
```

Copy the output and add these secrets to your GitHub repository.

## 3. GitHub Secrets Configuration

In your GitHub repository (https://github.com/dityakp/strapi-application-ecs-fargate):

1. Go to Settings > Secrets and variables > Actions
2. Add the following secrets:
   - `AWS_ACCESS_KEY_ID` (your AWS access key)
   - `AWS_SECRET_ACCESS_KEY` (your AWS secret key)
   - `DB_PASSWORD` (from generate:secrets output)
   - `APP_KEYS` (from generate:secrets output)
   - `API_TOKEN_SALT` (from generate:secrets output)
   - `ADMIN_JWT_SECRET` (from generate:secrets output)
   - `TRANSFER_TOKEN_SALT` (from generate:secrets output)
   - `JWT_SECRET` (from generate:secrets output)

## 4. Deploy

Push your code to the main branch:

```bash
git add .
git commit -m "Add ECS Fargate deployment with GitHub Actions"
git push origin main
```

The GitHub Actions workflow will automatically:
1. Build and push Docker image to ECR
2. Update Terraform infrastructure
3. Deploy new version to ECS Fargate

## 5. Access Your Application

After deployment completes, check the ECS console for the task's public IP address.

Your Strapi application will be available at: `http://task-public-ip:1337`

## What's Included

✅ **Infrastructure as Code**: Complete Terraform setup
✅ **Container Registry**: ECR with lifecycle policies
✅ **Database**: RDS PostgreSQL with proper security
✅ **ECS Fargate**: Direct container access with public IPs
✅ **Monitoring**: CloudWatch logs and health endpoints
✅ **CI/CD**: GitHub Actions for automated deployments
✅ **Security**: Proper security groups and network configuration
✅ **Health Checks**: Container health monitoring

## Architecture

```
GitHub → Actions → ECR → ECS Fargate (Public IP) → Internet
                    ↓
                  RDS PostgreSQL
```

The deployment is production-ready with proper security, monitoring, and automated deployments!