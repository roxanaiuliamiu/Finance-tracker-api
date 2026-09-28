# Finance Tracker API

A production-grade FastAPI backend for personal finance tracking with PostgreSQL, JWT authentication, and full AWS cloud deployment.

## 🚀 Features

- **User Authentication**: JWT-based auth with password hashing (bcrypt)
- **Expense Management**: Create, read, update, and delete financial transactions
- **Database**: PostgreSQL with SQLAlchemy ORM
- **API Documentation**: Interactive Swagger UI at `/docs`
- **Cloud-Native**: Containerized with Docker, deployed on AWS Fargate
- **CI/CD Pipeline**: Automated GitHub Actions → ECR → ECS
- **Infrastructure as Code**: Terraform for reproducible deployments

## 📋 Tech Stack

### Backend
- **Framework**: FastAPI 0.110.0
- **ORM**: SQLAlchemy 2.0.25
- **Validation**: Pydantic 2.5.0
- **Auth**: python-jose + bcrypt
- **Server**: Uvicorn 0.27.0

### Infrastructure
- **Container Registry**: Amazon ECR
- **Compute**: AWS Fargate (ECS)
- **Database**: AWS RDS PostgreSQL
- **Load Balancer**: AWS Application Load Balancer
- **Networking**: VPC with public/private subnets
- **Logging**: CloudWatch Logs
- **IaC**: Terraform

### CI/CD
- **Version Control**: GitHub
- **Automation**: GitHub Actions
- **Build**: Docker multi-stage build
- **Deploy**: Automated to AWS

## 🏗️ Architecture

┌─────────────┐ │ GitHub │ │ (git push) │ └──────┬──────┘ │ ▼ ┌─────────────────────┐ │ GitHub Actions │ ◄─── Build Docker image │ CI/CD Pipeline │ ◄─── Push to ECR └─────────┬───────────┘ │ ▼ ┌─────────────┐ │ AWS ECR │ ◄─── Container Registry └──────┬──────┘ │ ▼ ┌─────────────────────┐ │ AWS Fargate (ECS) │ ◄─── Pull latest image │ finance-tracker- │ Run containerized app │ api-service │ └──────┬──────────────┘ │ ▼ ┌─────────────────────┐ │ Application Load │ ◄─── Route traffic │ Balancer (ALB) │ Health checks every 30s └──────┬──────────────┘ │ ┌────┴────────────────────┐ │ │ ▼ ▼ Public Subnet A Public Subnet B (AZ: eu-central-1a) (AZ: eu-central-1b)

Code
  Database (RDS PostgreSQL)
  VPC: Private subnet
  Multi-AZ: ✅ Enabled
Code

## 🔌 API Endpoints

### Health Check
- `GET /` → `{"message": "Finance Tracker API is running"}`

### Authentication
- `POST /auth/register` - Create new user
  ```json
  {
    "email": "user@example.com",
    "password": "SecurePassword123!"
  }
Response: {"id": 1, "email": "user@example.com"}

POST /auth/login - Authenticate user
JSON
{
  "email": "user@example.com",
  "password": "SecurePassword123!"
}
Response: {"access_token": "eyJ0...", "token_type": "bearer"}
Expenses
GET /expenses - List all expenses (requires auth)
POST /expenses - Create new expense (requires auth)
JSON
{
  "description": "Groceries",
  "amount": 45.50,
  "category": "Food",
  "date": "2026-09-28"
}
GET /expenses/{id} - Get expense by ID
PUT /expenses/{id} - Update expense
DELETE /expenses/{id} - Delete expense
Documentation
GET /docs - Interactive Swagger UI
GET /openapi.json - OpenAPI schema
🚀 Deployment
Prerequisites
AWS Account with appropriate IAM permissions
Terraform ≥ 1.0
GitHub account with repository
Docker (for local testing)
Quick Start (Terraform)
Clone the repository

bash
git clone https://github.com/roxanaiuliamiu/finance-tracker-api.git
cd finance-tracker-api
Configure AWS credentials

bash
aws configure
Initialize Terraform

bash
cd infra
terraform init
Review and apply infrastructure

bash
terraform plan
terraform apply
Get the ALB endpoint

bash
terraform output alb_endpoint
Test the API

bash
curl http://<ALB_ENDPOINT>/
Environment Variables
Set these in infra/terraform.tfvars:

HCL
project_name     = "finance-tracker-api"
aws_region       = "eu-central-1"
db_username      = "postgres"
db_password      = "TempPassword123!"
db_name          = "finance"
jwt_secret_key   = "your-secret-key-min-32-chars-long"
container_image  = "062956467421.dkr.ecr.eu-central-1.amazonaws.com/finance-tracker-api:latest"
📊 Project Structure
Code
finance-tracker-api/
├── app/
│   ├── __init__.py
│   ├── main.py                 # FastAPI application
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py           # Configuration
│   │   └── database.py         # Database connection
│   ├── api/
│   │   ├── __init__.py
│   │   ├── auth.py             # Authentication routes
│   │   └── expenses.py         # Expense routes
│   ├── models/
│   │   ├── __init__.py
│   │   ├── user.py             # User database model
│   │   └── expense.py          # Expense database model
│   └── schemas/
│       ├── __init__.py
│       ├── user.py             # User Pydantic schemas
│       └── expense.py          # Expense Pydantic schemas
├── infra/
│   ├── main.tf                 # Terraform root module
│   ├── ecs.tf                  # ECS/Fargate configuration
│   ├── rds.tf                  # RDS PostgreSQL configuration
│   ├── vpc.tf                  # VPC and networking
│   ├── variables.tf            # Variable definitions
│   ├── outputs.tf              # Output values
│   └── terraform.tfvars        # Variable values (not in Git)
├── tests/
│   ├── __init__.py
│   ├── test_auth.py            # Authentication tests
│   └── test_expenses.py        # Expense tests
├── .github/
│   └── workflows/
│       └── ci.yml              # GitHub Actions CI/CD
├── assets/
│   └── screenshots/            # Deployment proof & evidence
├── Dockerfile                  # Multi-stage Docker build
├── requirements.txt            # Python dependencies
├── .gitignore
└── README.md
🔐 Security
Passwords: Hashed with bcrypt (10 salt rounds)
Tokens: JWT with HS256 algorithm, 1-hour expiry
Database: RDS with encrypted storage
Network: Private database subnet, ALB in public subnet
Container: Non-root user (appuser) runs the application
Secrets: Use AWS Secrets Manager in production
🛠️ DevOps & AWS Cloud Deployment
This project demonstrates advanced DevOps and AWS cloud deployment skills through the following architectural decisions and implementations:

Deployment Architecture Decisions
🎯 Network Design: Public Subnet Deployment (Cost-Optimized for Non-Production)
I chose a public subnet deployment strategy for this non-production environment to:

Cost Savings:

Eliminated 2 VPC Interface Endpoints: -$14/month (~$7 each)
Removed NAT Gateway: -$32/month (not needed with public IPs)
Total savings: ~$46/month while maintaining functionality
How it works:

ECS tasks run in public subnets with auto-assigned public IPs
Tasks can directly access the internet without routing through expensive NAT infrastructure
ECR image pulls and CloudWatch log delivery happen over public internet
Security group still restricts inbound traffic to ALB only (port 8000)
Trade-offs:

✅ Lower cost (suitable for portfolio/demo)
⚠️ Tasks have public IP addresses (acceptable for non-production)
🔧 For production, would implement NAT Gateway or VPC endpoints
Production Alternative: For production workloads, I would implement:

HCL
# NAT Gateway in public subnet (1 per AZ for HA)
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_a.id
}

# Private route tables point to NAT Gateway
route {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}
🐳 Docker Multi-Stage Build Optimization
Problem Solved: Initial deployment failed with permission error:

Code
/root/.local/bin/uvicorn: [Errno 13] Permission denied
Root Cause: Packages installed in /root/.local (root-only), but container runs as non-root user (appuser)

Solution Implemented:

Dockerfile
# Install into /opt/venv (world-readable, not root-specific)
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Non-root user can now execute uvicorn
USER appuser
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
Security Benefits:

Reduced attack surface by running as non-root
Container breakout cannot gain root access
Follows Docker security best practices
🔄 CI/CD Pipeline: GitHub Actions → ECR → ECS
Automated Deployment Flow:

Push to main branch
GitHub Actions builds Docker image
Image tagged with :latest
Pushed to Amazon ECR
ECS service detects new image (via force-new-deployment)
Rolls out new version to Fargate tasks
ALB health checks verify new version is healthy
GitHub Actions Workflow (.github/workflows/ci.yml):

YAML
- Build & tag Docker image
- Push to ECR (auto-creates repo if needed)
- Trigger ECS service update
📊 Infrastructure as Code: Terraform
Modules Created:

vpc.tf - VPC, subnets, route tables, security groups
ecs.tf - ECS cluster, task definition, service configuration
rds.tf - PostgreSQL RDS instance with automated backups
main.tf - Root module orchestration
variables.tf - Input variables with validation
outputs.tf - Export ALB endpoint, RDS endpoint, etc.
Key Improvements Made:

Fixed database connectivity: Added DATABASE_URL environment variable to task definition
Removed unnecessary VPC endpoints: Reduced cost and complexity
Configured proper IAM roles: Separate execution role and task role
Health checks: ALB pinging /docs every 30 seconds
Multi-AZ RDS: Automatic failover capability
🔍 Debugging & Troubleshooting
Issues Encountered & Resolved:

Issue	Root Cause	Solution
ResourceInitializationError	Tasks in private subnets couldn't reach CloudWatch	Moved tasks to public subnets
Permission denied on uvicorn	Packages in /root/.local, user is appuser	Changed to /opt/venv
Database connection failed	Missing DATABASE_URL env variable	Added to task definition
ECR push failed	Invalid account ID in registry URL	Updated with correct account ID (062956467421)
Tasks kept stopping	No database connectivity, app crashed on startup	Verified RDS endpoint and security groups
Debugging Commands Used:

bash
# View ECS task events and stop reasons
aws ecs describe-services --cluster <name> --services <name> --region eu-central-1

# Stream application logs in real-time
aws logs tail /ecs/finance-tracker-api --follow

# Check task details (stopCode, stoppedReason)
aws ecs describe-tasks --cluster <name> --tasks <id> --region eu-central-1

# Verify RDS connectivity
aws rds describe-db-instances --region eu-central-1

# List ECR images and tags
aws ecr describe-images --repository-name finance-tracker-api --region eu-central-1
📈 Deployment Proof
See assets/screenshots/ for evidence of successful deployment:

✅ GitHub Actions Workflow: Successful build & push to ECR
✅ ECS Service: 1 running task with healthy status
✅ ALB Health Checks: Target marked as healthy
✅ CloudWatch Logs: Application startup and request logs
✅ API Response: Health check and user registration endpoints working
✅ Swagger UI: Interactive API documentation at /docs
💡 Key Learnings Demonstrated
Cost Optimization: Made architectural decisions balancing cost vs. production requirements
AWS Services: ECR, Fargate, RDS, ALB, VPC, CloudWatch, IAM
Terraform: Resource management, variables, outputs, state management
Docker: Multi-stage builds, security (non-root user), image optimization
CI/CD: GitHub Actions automation, artifact management
Networking: VPC design, subnets, security groups, routing
Debugging: CloudWatch logs, AWS CLI, systematic troubleshooting
Infrastructure as Code: Reproducible, version-controlled infrastructure
💰 Cost Analysis
Monthly Cost Breakdown (for this non-production deployment):

Service	Cost	Notes
Fargate (256 CPU, 512 MB)	~$3.50	1 task × 730 hours
RDS PostgreSQL (db.t3.micro)	~$10-15	Multi-AZ disabled for cost savings
Application Load Balancer	~$15-20	~0.02/hour + data processing
ECR Storage	<$1	Minimal image storage
Total	~$28-38	Per month
Cost Reduction Achieved:

Removed 2 VPC Interface Endpoints: -$14/month
Removed NAT Gateway: -$32/month
Savings: -$46/month while maintaining full functionality
For Production: Would add NAT Gateway ($32/month) and VPC endpoints ($7/month each) for better security and private database access.

📦 Local Development
Setup Python Virtual Environment
bash
python3.11 -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
Run Locally
bash
uvicorn app.main:app --reload --port 8000
Visit http://localhost:8000/docs for interactive API documentation.

Run Tests
bash
pytest --cov=app tests/
🐳 Docker Build
Build the image locally:

bash
docker build -t finance-tracker-api:latest .
docker run -it -p 8000:8000 \
  -e DATABASE_URL="postgresql://postgres:password@db:5432/finance" \
  -e JWT_SECRET_KEY="your-secret-key" \
  finance-tracker-api:latest
🛑 Cleanup
To avoid charges, destroy AWS resources when not in use:

bash
cd infra
terraform destroy
This removes:

ECS cluster and service
ECR repository
RDS instance
VPC and subnets
ALB and target groups
IAM roles and policies
🤝 Contributing
Create a feature branch: git checkout -b feature/your-feature
Commit changes: git commit -am 'add: your feature'
Push to branch: git push origin feature/your-feature
GitHub Actions automatically builds and tests
📝 Environment Setup
GitHub Actions Secrets
Set these in repository settings for automated deployments:

Code
AWS_ACCOUNT_ID=062956467421
AWS_ROLE_NAME=finance-tracker-api-github-role
AWS_REGION=eu-central-1
These enable OIDC-based authentication (no long-lived access keys).

🐛 Troubleshooting
ECS Task won't start
Check CloudWatch logs:

bash
aws logs tail /ecs/finance-tracker-api --region eu-central-1 --follow
Can't connect to database
Verify security group allows:

Port 5432 (PostgreSQL)
Source: ECS security group
Image not found in ECR
Confirm GitHub Actions completed successfully and image was pushed:

bash
aws ecr describe-images \
  --repository-name finance-tracker-api \
  --region eu-central-1
📚 Resources
FastAPI Documentation
AWS Fargate
Terraform AWS Provider
GitHub Actions
SQLAlchemy ORM
AWS Best Practices
📄 License
This project is open source and available under the MIT License.

This project is based on finance-tracker-api by Ajero Franklin (Franklindot04), licensed under the MIT License.

Modifications and deployment configuration are maintained by ROXANA-IULIA MIU.


GitHub: @roxanaiuliamiu
Last Updated: September 28, 2026
Status: ✅ Production-Ready Architecture (Cost-Optimized for Non-Production Demo)