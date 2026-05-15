# Ecolibrium DevOps Assignment

## Project Overview

This project demonstrates an end-to-end DevOps implementation on AWS using Terraform, Amazon EKS, Docker, Helm, and Jenkins.

The objective of this assignment was to:

- Provision AWS infrastructure using Terraform
- Deploy a containerized application on Kubernetes (EKS)
- Create a custom Helm chart
- Implement CI/CD automation using Jenkins
- Store container images in Amazon ECR

---

# Architecture

AWS Infrastructure created using Terraform:

- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables
- Amazon EKS Cluster
- Managed Node Group
- IAM Roles and Policies
- Amazon ECR Repository

Application Deployment Stack:

- Docker
- Amazon ECR
- Kubernetes EKS
- Helm
- Jenkins CI/CD Pipeline

---

# Project Structure

```bash
.
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── vpc.tf
│   ├── eks.tf
│   ├── iam.tf
│   ├── outputs.tf
│   └── ecr.tf
│
├── app/
│   ├── Dockerfile
│   └── index.html
│
├── nginx-chart/
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── ingress.yaml
│       ├── configmap.yaml
│       └── serviceaccount.yaml
│
├── Jenkinsfile
├── README.md
```

---

# Technologies Used

| Tool | Purpose |
|------|----------|
| Terraform | Infrastructure Provisioning |
| AWS EKS | Kubernetes Cluster |
| Docker | Containerization |
| Amazon ECR | Container Registry |
| Helm | Kubernetes Package Management |
| Jenkins | CI/CD Automation |

---

# Infrastructure Provisioning Using Terraform

Terraform was used to provision the complete AWS infrastructure.

## Resources Created

### Networking
- VPC
- Public Subnets
- Private Subnets
- Internet Gateway
- NAT Gateway
- Route Tables

### EKS Infrastructure
- Amazon EKS Cluster
- Managed Node Group
- IAM Roles and Policies

### Container Registry
- Amazon ECR Repository

---

# Terraform Deployment Steps

## Initialize Terraform

```bash
terraform init
```

## Validate Terraform Files

```bash
terraform validate
```

## Format Terraform Files

```bash
terraform fmt
```

## Apply Infrastructure

```bash
terraform apply -auto-approve
```

## Destroy Infrastructure

```bash
terraform destroy -auto-approve
```

---

# Docker Application

A lightweight NGINX-based web application was created.

## Application Files

- `index.html`
- `Dockerfile`

## Docker Build

```bash
docker build -t demo-app .
```

---

# Amazon ECR

The Docker image is pushed to Amazon ECR.

## ECR Login

```bash
aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-2.amazonaws.com
```

## Docker Tag

```bash
docker tag demo-app:latest <ecr-repository-url>:latest
```

## Docker Push

```bash
docker push <ecr-repository-url>:latest
```

---

# Kubernetes Deployment Using Helm

A custom Helm chart was created for application deployment.

## Helm Components Included

- Deployment
- Service
- Ingress
- ConfigMap
- VolumeMounts
- Environment Variables
- Liveness Probe
- Readiness Probe
- Customizable values.yaml

---

# Helm Deployment

## Install Helm Chart

```bash
helm install demo-app .
```

## Upgrade Helm Chart

```bash
helm upgrade demo-app .
```

---

# Kubernetes Features Implemented

## Deployment
Manages application pods and replica scaling.

## Service
A LoadBalancer service exposes the application externally.

## Ingress
Ingress resource added for routing configuration.

## ConfigMap
Used for external configuration management.

## VolumeMounts
ConfigMap mounted inside the container.

## Environment Variables
Environment-specific values injected into containers.

## Liveness Probe
Checks whether the application container is alive.

## Readiness Probe
Checks whether the application is ready to receive traffic.

---

# Jenkins CI/CD Pipeline

A Jenkins Declarative Pipeline was implemented for full CI/CD automation.

## Pipeline Stages

1. Checkout Code
2. Configure AWS Credentials
3. Terraform Init
4. Terraform Apply
5. Docker Build
6. ECR Login
7. Docker Tag
8. Docker Push
9. Configure Kubeconfig
10. Install NGINX Ingress Controller
11. Wait For Ingress Controller
12. Helm Deploy
13. Verify Deployment

---

# Jenkins Features

- Dynamic AWS Account ID retrieval
- Jenkins Credentials Manager integration
- Automated EKS deployment
- Automated Docker image push to ECR
- Automated Helm deployment

---

# Kubernetes Verification Commands

## Check Nodes

```bash
kubectl get nodes
```

## Check Pods

```bash
kubectl get pods
```

## Check Services

```bash
kubectl get svc
```

## Check Ingress

```bash
kubectl get ingress
```

---

# Application Access

The application is exposed using:

- Kubernetes LoadBalancer Service
- AWS Elastic Load Balancer (ELB)

Application URL can be obtained using:

```bash
kubectl get svc
```

---

# Security Best Practices Followed

- AWS credentials stored in Jenkins Credentials Manager
- Terraform variables separated using `terraform.tfvars`
- Infrastructure managed using Infrastructure as Code principles
- Reusable and parameterized Jenkins pipeline

---

# Outcome

Successfully implemented:

- Infrastructure as Code
- Kubernetes deployment automation
- CI/CD pipeline automation
- Docker containerization
- AWS cloud infrastructure provisioning
- Helm-based Kubernetes deployments

---

# Steps to Run the Application Manually

## 1. Clone Repository

```bash
git clone https://github.com/Gopi9398/ecolibrium-devops-assignment.git
cd ecolibrium-devops-assignment
```

---

# 2. Provision AWS Infrastructure

Move to Terraform directory:

```bash
cd terraform
```

Initialize Terraform:

```bash
terraform init
```

Validate Terraform files:

```bash
terraform validate
```

Apply infrastructure:

```bash
terraform apply -auto-approve
```

This creates:
- VPC
- Public and Private Subnets
- Internet Gateway
- NAT Gateway
- EKS Cluster
- Managed Node Group
- IAM Roles
- ECR Repository

---

# 3. Configure kubectl for EKS

```bash
aws eks update-kubeconfig \
--region ap-south-2 \
--name demo-eks-cluster
```

Verify cluster access:

```bash
kubectl get nodes
```

---

# 4. Build Docker Image

Move to application directory:

```bash
cd ../app
```

Build Docker image:

```bash
docker build -t demo-app .
```

---

# 5. Login to Amazon ECR

```bash
aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin Account-ID.dkr.ecr.ap-south-2.amazonaws.com
```

---

# 6. Tag Docker Image

```bash
docker tag demo-app:latest Account-ID.dkr.ecr.ap-south-2.amazonaws.com/demo-app:latest
```

---

# 7. Push Docker Image to ECR

```bash
docker push Account-ID.dkr.ecr.ap-south-2.amazonaws.com/demo-app:latest
```

---

# 8. Deploy Application Using Helm

Move to Helm chart directory:

```bash
cd ../nginx-chart
```

Install Helm chart:

```bash
helm install demo-app .
```

Or upgrade deployment:

```bash
helm upgrade --install demo-app .
```

---

# 9. Verify Kubernetes Resources

Check pods:

```bash
kubectl get pods
```

Check services:

```bash
kubectl get svc
```

Check ingress:

```bash
kubectl get ingress
```

---

# 10. Access the Application

Get external LoadBalancer URL:

```bash
kubectl get svc
```

Open the `EXTERNAL-IP` or LoadBalancer DNS in browser.

Example:

```bash
http://<load-balancer-url>
```

---

# 11. Run Complete CI/CD Pipeline Using Jenkins

The Jenkins pipeline automates:

- Terraform Infrastructure Provisioning
- Docker Image Build
- Docker Push to Amazon ECR
- Kubernetes Deployment
- Helm Deployment
- Ingress Controller Installation

Pipeline execution steps:

1. Open Jenkins
2. Create Pipeline Job
3. Connect GitHub Repository
4. Configure AWS Credentials
5. Run "Build Now"

Jenkins automatically deploys the complete infrastructure and application.

# Author

Gopi Krishna
