# DevOps Solutions Architect Exam Questions & Answers 2026

## Exam Blueprint

| Domain | % of Exam |
|--------|-----------|
| CI/CD Pipeline Design | 20% |
| Containerization & Orchestration | 25% |
| Cloud Architecture (AWS/Azure/GCP) | 20% |
| Infrastructure as Code | 15% |
| Monitoring & Observability | 10% |
| Security & Compliance | 10% |

---

## Domain 1: CI/CD Pipeline Design (20%)

### Question 1: Design a CI/CD Pipeline for a Multi-Cloud Deployment

**Scenario:** A company wants to deploy applications to both AWS and Azure using a single CI/CD pipeline. Design the pipeline architecture.

**Answer:**

```
┌─────────────────────────────────────────────────────────────────┐
│                        SOURCE CONTROL (GitHub)                   │
└─────────────────────────────────┬───────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                      CI PIPELINE (GitHub Actions)                │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐        │
│  │ Checkout │→ │  Build  │→ │  Test  │→ │ Security│        │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘        │
│       │                                           │             │
│       │            ┌─────────┐  ┌─────────┐     │             │
│       └──────────→ │ Package │→ │  Scan  │←────┘             │
│                    └─────────┘  └─────────┘                   │
└─────────────────────────────────┬───────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────┐
│                      DEPLOYMENT STAGE                           │
│                                                                  │
│  ┌──────────────────────────────────────────────────────┐     │
│  │                    AWS Deployment                     │     │
│  │  ECR → ECS Fargate → CloudFormation                 │     │
│  └──────────────────────────────────────────────────────┘     │
│                              │                                 │
│  ┌──────────────────────────────────────────────────────┐     │
│  │                   Azure Deployment                    │     │
│  │  ACR → Azure Container Apps → ARM Templates           │     │
│  └──────────────────────────────────────────────────────┘     │
└─────────────────────────────────────────────────────────────────┘
```

**Implementation:**

```yaml
# GitHub Actions Pipeline
name: Multi-Cloud Deployment

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build Docker Image
        run: |
          docker build -t myapp:${{ github.sha }} .
          docker build -t myapp:latest .
      
      - name: Security Scan
        uses: aquasecurity/trivy-action@master
        
      - name: Push to AWS ECR
        if: success()
        run: |
          aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com
          docker tag myapp:${{ github.sha }} $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/myapp:${{ github.sha }}
          docker push $AWS_ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/myapp:${{ github.sha }}
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      
      - name: Push to Azure ACR
        if: success()
        run: |
          az acr login --name myregistry
          docker tag myapp:${{ github.sha }} myregistry.azurecr.io/myapp:${{ github.sha }}
          docker push myregistry.azurecr.io/myapp:${{ github.sha }}
        env:
          AZURE_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
          AZURE_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
```

---

### Question 2: Implement Blue-Green Deployment Strategy

**Scenario:** Design a zero-downtime deployment strategy using Blue-Green deployment.

**Answer:**

```yaml
# Blue-Green Deployment Terraform Code

resource "aws_lb" "main" {
  name               = "myapp-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb.id]
  subnets           = aws_subnet.public[*].id
}

resource "aws_lb_target_group" "blue" {
  name     = "myapp-blue"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  
  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_target_group" "green" {
  name     = "myapp-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  
  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }
}

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port             = 80
  protocol         = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue.arn
  }
}

# CodeDeploy Blue-Green Deployment
resource "aws_codedeploy_deployment_group" "blue_green" {
  app_name              = aws_codedeploy_app.main.name
  deployment_group_name = "production"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  
  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    
    terminate_blue_instances {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
  
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
```

---

### Question 3: Implement GitOps Workflow with ArgoCD

**Scenario:** Design a GitOps workflow using ArgoCD for Kubernetes deployments.

**Answer:**

```yaml
# ArgoCD Application Definition
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: myapp-production
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/company/myapp-gitops.git
    targetRevision: main
    path: production
  destination:
    server: https://kubernetes.default.svc
    namespace: production
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
    retry:
      limit: 5
      backoff:
        duration: 5s
        factor: 2
        maxDuration: 3m
```

```yaml
# GitOps Repository Structure
# repo/
# ├── production/
# │   ├── deployment.yaml
# │   ├── service.yaml
# │   ├── ingress.yaml
# │   └── kustomization.yaml
# ├── staging/
# │   ├── deployment.yaml
# │   ├── service.yaml
# │   └── kustomization.yaml
# └── base/
#     ├── deployment.yaml
#     └── service.yaml
```

```bash
# Kustomization for Production
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - ../base

replicas:
  - name: myapp
    count: 5

images:
  - name: myapp
    newTag: v2.1.0

commonLabels:
  environment: production
```

---

## Domain 2: Containerization & Orchestration (25%)

### Question 4: Design a Production-Ready Kubernetes Architecture

**Scenario:** Design a production Kubernetes cluster with high availability, security, and scalability.

**Answer:**

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    AWS EKS Production Architecture                       │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CONTROL PLANE (Managed by AWS)                │   │
│  │  API Server │ etcd │ Scheduler │ Controller Manager          │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                          │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    VPC (10.0.0.0/16)                            │   │
│  │                                                                  │   │
│  │  ┌─────────────────┐          ┌─────────────────┐            │   │
│  │  │ Public Subnet   │          │ Public Subnet   │            │   │
│  │  │ us-east-1a      │          │ us-east-1b      │            │   │
│  │  │                 │          │                 │            │   │
│  │  │ ┌─────────────┐│          │ ┌─────────────┐│            │   │
│  │  │ │  ALB       ││          │ │  ALB       ││            │   │
│  │  │ └─────────────┘│          │ └─────────────┘│            │   │
│  │  └─────────────────┘          └─────────────────┘            │   │
│  │            │                         │                        │   │
│  │  ┌────────┴────────┐          ┌──────┴────────┐            │   │
│  │  │ Private Subnet  │          │ Private Subnet│            │   │
│  │  │   us-east-1a   │          │  us-east-1b   │            │   │
│  │  │                │          │               │            │   │
│  │  │ ┌───────────┐  │          │ ┌───────────┐  │            │   │
│  │  │ │ Worker    │  │          │ │ Worker    │  │            │   │
│  │  │ │ Node 1    │  │          │ │ Node 2    │  │            │   │
│  │  │ │ (System)  │  │          │ │ (System)  │  │            │   │
│  │  │ └───────────┘  │          │ └───────────┘  │            │   │
│  │  │ ┌───────────┐  │          │ ┌───────────┐  │            │   │
│  │  │ │ Worker    │  │          │ │ Worker    │  │            │   │
│  │  │ │ Node 3    │  │          │ │ Node 4    │  │            │   │
│  │  │ │ (App)     │  │          │ │ (App)     │  │            │   │
│  │  │ └───────────┘  │          │ └───────────┘  │            │   │
│  │  └─────────────────┘          └─────────────────┘            │   │
│  │                                                                  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

```yaml
# Production-Ready Node Group with taint/toleration
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig
metadata:
  name: production-cluster
  region: us-east-1

managedNodeGroups:
  - name: system
    instanceType: m5.xlarge
    desiredCapacity: 2
    minSize: 2
    maxSize: 4
    volumeSize: 100
    labels:
      node-type: system
    taints:
      - key: node-type
        value: system
        effect: NoSchedule
  
  - name: application
    instanceType: m5.2xlarge
    desiredCapacity: 4
    minSize: 2
    maxSize: 10
    volumeSize: 200
    labels:
      node-type: application
    taints:
      - key: node-type
        value: application
        effect: NoExecute
    autoscaling:
      minSize: 2
      maxSize: 10
      desiredCapacity: 4

# Pod Disruption Budget
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: myapp-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: myapp

---
# Vertical Pod Autoscaler
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: myapp-vpa
spec:
  targetRef:
    apiVersion: "apps/v1"
    kind: Deployment
    name: myapp
  updatePolicy:
    updateMode: "Auto"
```

---

### Question 5: Implement Service Mesh with Istio

**Scenario:** Implement a service mesh to handle traffic management, security, and observability.

**Answer:**

```yaml
# Istio Gateway Configuration
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: myapp-gateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "myapp.example.com"
    tls:
      httpsRedirect: true
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "myapp.example.com"
    tls:
      mode: SIMPLE
      credentialName: myapp-cert

---
# Virtual Service with Traffic Splitting
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: myapp
spec:
  hosts:
  - "myapp.example.com"
  gateways:
  - myapp-gateway
  http:
  - match:
    - uri:
        prefix: /api
    route:
    - destination:
        host: myapp-api
        port:
          number: 8080
    retries:
      attempts: 3
      perTryTimeout: 2s
    timeout: 10s
  
  - match:
    - uri:
        prefix: /v2
    route:
    - destination:
        host: myapp-v2
        weight: 100
    - destination:
        host: myapp-v1
        weight: 0
  
  - route:
    - destination:
        host: myapp-web
        weight: 100

---
# Destination Rules for Circuit Breaker
apiVersion: networking.istio.io/v1beta1
kind: DestinationRule
metadata:
  name: myapp-destination
spec:
  host: myapp
  trafficPolicy:
    connectionPool:
      tcp:
        maxConnections: 100
      http:
        h2UpgradePolicy: UPGRADE
        http1MaxPendingRequests: 100
        http2MaxRequests: 1000
        maxRequestsPerConnection: 10
    outlierDetection:
      consecutive5xxErrors: 5
      interval: 30s
      baseEjectionTime: 30s
      maxEjectionPercent: 50

---
# Authorization Policy
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: myapp-auth
spec:
  selector:
    matchLabels:
      app: myapp
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/default/sa/frontend"]
    to:
    - operation:
        methods: ["GET"]
        paths: ["/api/*"]
```

---

### Question 6: Implement Kubernetes Security Best Practices

**Answer:**

```yaml
# Pod Security Standards
apiVersion: v1
kind: Namespace
metadata:
  name: production
  labels:
    pod-security.kubernetes.io/enforce: restricted
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted

---
# Network Policy
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: myapp-network-policy
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - port: 8080
  - from:
    - namespaceSelector:
        matchLabels:
          name: ingress-nginx
    ports:
    - port: 8080
  egress:
  - to:
    - podSelector:
        matchLabels:
          role: database
    ports:
    - port: 5432
  - to:
    - namespaceSelector: {}
      podSelector:
        matchLabels:
          k8s-app: kube-dns
    ports:
    - port: 53
      protocol: UDP

---
# Security Context
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 1000
  containers:
  - name: myapp
    image: myapp:v1
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
    resources:
      limits:
        memory: "512Mi"
        cpu: "500m"
      requests:
        memory: "256Mi"
        cpu: "250m"
    volumeMounts:
    - name: tmp
      mountPath: /tmp
  volumes:
  - name: tmp
    emptyDir: {}
```

---

## Domain 3: Cloud Architecture (20%)

### Question 7: Design a Multi-Region Disaster Recovery Architecture

**Answer:**

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      DISASTER RECOVERY ARCHITECTURE                     │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│   PRIMARY REGION (us-east-1)          SECONDARY REGION (us-west-2)    │
│                                                                          │
│  ┌───────────────────────┐          ┌───────────────────────┐        │
│  │       Route 53         │          │       Route 53         │        │
│  │    Health Checks       │          │    Health Checks       │        │
│  │         ↓              │          │         ↓              │        │
│  │    Active Traffic       │◄────────►│    Standby Traffic    │        │
│  └───────────────────────┘   Failover   └───────────────────────┘        │
│              │                                            │              │
│              ▼                                            ▼              │
│  ┌───────────────────────┐          ┌───────────────────────┐        │
│  │   Application LB       │          │   Application LB       │        │
│  │   (Multi-AZ)         │          │   (Multi-AZ)         │        │
│  └───────────────────────┘          └───────────────────────┘        │
│              │                                            │              │
│              ▼                                            ▼              │
│  ┌───────────────────────┐          ┌───────────────────────┐        │
│  │   EKS Cluster        │   RDS    │   EKS Cluster        │        │
│  │   (3 Nodes/AZ)       │◄────────►│   (3 Nodes/AZ)       │        │
│  └───────────────────────┘   Sync   └───────────────────────┘        │
│              │                                            │              │
│              ▼                                            ▼              │
│  ┌───────────────────────┐          ┌───────────────────────┐        │
│  │   RDS Aurora (Primary) │───────────►│   RDS Aurora (Replica)│        │
│  │   Writer Endpoint     │  Async    │   Reader Endpoint     │        │
│  └───────────────────────┘  Replication  └───────────────────────┘        │
│                                                                          │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    S3 Cross-Region Replication                   │   │
│  │     Primary Bucket ──────────────────────────► Replica Bucket    │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

```yaml
# RDS Aurora Multi-Master Global Database
resource "aws_rds_global_cluster" "global" {
  global_cluster_identifier = "myapp-global"
  engine                  = "aurora-postgresql"
  engine_version         = "15.3"
  database_name           = "myapp"
  storage_encrypted       = true
}

resource "aws_rds_cluster" "primary" {
  cluster_identifier        = "myapp-primary"
  global_cluster_identifier = aws_rds_global_cluster.global.id
  engine                   = aws_rds_global_cluster.global.engine
  engine_version           = aws_rds_global_cluster.global.engine_version
  database_name            = "myapp"
  master_username          = "admin"
  master_password          = var.db_password
  skip_final_snapshot      = true
  backup_retention_period  = 7
  preferred_backup_window  = "03:00-04:00"
}

resource "aws_rds_cluster_instance" "primary_instances" {
  count              = 3
  identifier         = "myapp-primary-${count.index}"
  cluster_identifier = aws_rds_cluster.primary.id
  instance_class    = "db.r7g.large"
  engine            = aws_rds_cluster.primary.engine
  engine_version    = aws_rds_cluster.primary.engine_version
}

# Route 53 Health Check and Failover
resource "aws_route53_health_check" "primary" {
  fqdn              = "myapp.example.com"
  port              = 443
  type              = "HTTPS"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval = 30
}

resource "aws_route53_record" "myapp" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "myapp.example.com"
  type    = "A"

  failover_routing_policy {
    type = "PRIMARY"
  }

  set_identifier  = "primary"
  health_check_id = aws_route53_health_check.primary.id

  alias {
    name                   = aws_lb.primary.dns_name
    zone_id                = aws_lb.primary.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "myapp_secondary" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "myapp.example.com"
  type    = "A"

  failover_routing_policy {
    type = "SECONDARY"
  }

  set_identifier = "secondary"

  alias {
    name                   = aws_lb.secondary.dns_name
    zone_id                = aws_lb.secondary.zone_id
    evaluate_target_health = true
  }
}
```

---

### Question 8: Implement Serverless Architecture with AWS Lambda

**Answer:**

```yaml
# Serverless Architecture with API Gateway and Lambda
resource "aws_apigatewayv2_api" "api" {
  name          = "myapp-api"
  protocol_type = "HTTP"
  
  cors_configuration {
    allow_origins = ["https://myapp.example.com"]
    allow_methods = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_headers = ["*"]
  }
}

resource "aws_apigatewayv2_stage" "prod" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "prod"
  auto_deploy = true
  
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api.access_log_arn
    format = jsonencode({
      requestId      = "$context.requestId"
      sourceIp       = "$context.identity.sourceIp"
      requestTime    = "$context.requestTime"
      protocol       = "$context.protocol"
      httpMethod     = "$context.httpMethod"
      resourcePath  = "$context.resourcePath"
      routeKey      = "$context.routeKey"
      status        = "$context.status"
      responseLength = "$context.responseLength"
    })
  }
}

resource "aws_lambda_function" "handler" {
  function_name    = "myapp-handler"
  filename         = "lambda_function.zip"
  handler          = "index.handler"
  runtime          = "nodejs18.x"
  role            = aws_iam_role.lambda.arn
  timeout         = 30
  memory_size     = 256
  
  environment {
    variables = {
      DATABASE_URL = aws_secretsmanager_secret.db.arn
      NODE_ENV      = "production"
    }
  }
  
  vpc_config {
    subnet_ids         = aws_subnet.private[*].id
    security_group_ids = [aws_security_group.lambda.id]
  }
  
  dead_letter_config {
    target_arn = aws_sqs_queue.dlq.arn
  }
  
  lifecycle {
    ignore_changes = [last_modified]
  }
}

resource "aws_lambda_function_url" "function_url" {
  function_name      = aws_lambda_function.handler.function_name
  authorization_type = "AWS_IAM"
  cors {
    allowCredentials = true
    allowHeaders     = ["*"]
    allowMethods     = ["GET", "POST"]
    allowOrigins     = ["https://myapp.example.com"]
  }
}

# Lambda Provisioned Concurrency for Cold Start Optimization
resource "aws_lambda_provisioned_concurrency_config" "prod" {
  function_name                     = aws_lambda_function.handler.function_name
  qualifier                        = aws_lambda_alias.production.name
  provisioned_concurrent_executions = 5
  
  lifecycle {
    create_before_destroy = true
  }
}
```

---

## Domain 4: Infrastructure as Code (15%)

### Question 9: Design a Multi-Environment Terraform Configuration

**Answer:**

```hcl
# Root Module Structure
# terraform/
# ├── environments/
# │   ├── dev/
# │   │   ├── main.tf
# │   │   ├── variables.tf
# │   │   └── terraform.tfvars
# │   ├── staging/
# │   ├── production/
# ├── modules/
# │   ├── networking/
# │   ├── compute/
# │   ├── database/
# └── backend.tf

# Production Environment Configuration
# environments/production/main.tf

terraform {
  backend "s3" {
    bucket         = "mycompany-terraform-state"
    key            = "production/myapp/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}

module "networking" {
  source = "../../../modules/networking"
  
  environment = "production"
  vpc_cidr    = "10.1.0.0/16"
  
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  private_subnets = ["10.1.10.0/24", "10.1.11.0/24", "10.1.12.0/24"]
}

module "eks" {
  source = "../../../modules/eks"
  
  environment         = "production"
  cluster_version     = "1.27"
  vpc_id             = module.networking.vpc_id
  subnet_ids         = module.networking.private_subnet_ids
  
  node_groups = {
    system = {
      instance_types = ["m5.xlarge"]
      min_size      = 3
      max_size      = 6
      desired_size  = 3
    }
    application = {
      instance_types = ["m5.2xlarge"]
      min_size      = 3
      max_size      = 12
      desired_size  = 6
    }
  }
  
  cluster_encryption_config = {
    resources = ["secrets"]
    provider_key_arn = aws_kms_key.cluster.arn
  }
}

module "rds" {
  source = "../../../modules/database"
  
  environment     = "production"
  vpc_id         = module.networking.vpc_id
  subnet_ids     = module.networking.private_subnet_ids
  security_group = module.networking.database_security_group_id
  
  multi_az               = true
  storage_encrypted      = true
  deletion_protection    = true
  backup_retention_period = 30
  
  performance_insights_enabled = true
  monitoring_interval        = 60
}

# Terragrunt Configuration
# environments/production/terragrunt.hcl

locals {
  environment = "production"
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "mycompany-terraform-state"
    key            = "production/${path_relative_path_only}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"
  
  default_tags {
    tags = {
      Environment = "${local.environment}"
      ManagedBy   = "Terraform"
    }
  }
}
EOF
}

inputs = {
  environment = local.environment
}
```

---

### Question 10: Implement Terraform Testing Strategy

**Answer:**

```hcl
# Terratest Example
# test/integration_test.go

package test

import (
    "testing"
    "time"
    
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestEKSCluster(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../examples/eks-cluster",
        Vars: map[string]interface{}{
            "cluster_name": "test-cluster",
            "cluster_version": "1.27",
        },
    }
    
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)
    
    // Get cluster endpoint
    clusterEndpoint := terraform.Output(t, terraformOptions, "cluster_endpoint")
    assert.NotEmpty(t, clusterEndpoint)
    
    // Get cluster name
    clusterName := terraform.Output(t, terraformOptions, "cluster_name")
    assert.Equal(t, "test-cluster", clusterName)
    
    // Verify node group was created
    nodeGroupCount := terraform.Output(t, terraformOptions, "node_group_count")
    assert.Equal(t, "2", nodeGroupCount)
}

func TestRDSInstance(t *testing.T) {
    terraformOptions := &terraform.Options{
        TerraformDir: "../modules/database/examples/rds",
        Vars: map[string]interface{}{
            "environment": "test",
            "multi_az": true,
        },
    }
    
    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)
    
    // Get RDS endpoint
    rdsEndpoint := terraform.Output(t, terraformOptions, "rds_endpoint")
    assert.NotEmpty(t, rdsEndpoint)
    
    // Verify backup retention
    backupRetention := terraform.Output(t, terraformOptions, "backup_retention_period")
    assert.Equal(t, "7", backupRetention)
}
```

```bash
# Test Commands
# Run unit tests
go test -v ./test/...

# Run integration tests
terratest test plan

# Check Terraform code quality
tfsec .

# Check for security issues
checkov -d .

# Format and validate
terraform fmt -recursive
terraform validate

# Plan with drift detection
terraform plan -detailed-exitcode
```

---

## Domain 5: Monitoring & Observability (10%)

### Question 11: Implement Comprehensive Monitoring Stack

**Answer:**

```yaml
# Prometheus and Grafana Deployment
apiVersion: v1
kind: Namespace
metadata:
  name: monitoring
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  namespace: monitoring
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    
    alerting:
      alertmanagers:
      - static_configs:
        - targets:
          - alertmanager.monitoring.svc:9093
    
    rule_files:
    - /etc/prometheus/rules/*.yml
    
    scrape_configs:
    - job_name: 'kubernetes-nodes'
      scrape_interval: 30s
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - source_labels: [__address__]
        regex: '(.*):10250'
        replacement: '${1}:9100'
        target_label: __metrics_path__
    
    - job_name: 'kubernetes-pods'
      kubernetes_sd_configs:
      - role: pod
      relabel_configs:
      - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
        action: keep
        regex: true
    
    - job_name: 'kubernetes-services'
      kubernetes_sd_configs:
      - role: service
      relabel_configs:
      - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
        action: keep
        regex: true

---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: prometheus
  namespace: monitoring
spec:
  replicas: 2
  retention: 30d
  retentionSize: 100GiB
  resources:
    requests:
      memory: 2Gi
      cpu: 1000m
    limits:
      memory: 4Gi
      cpu: 2000m
  serviceAccountName: prometheus
  serviceMonitorSelector:
    matchLabels:
      team: frontend
  ruleSelector:
    matchLabels:
      role: alert-rules
  alerting:
    alertmanagers:
    - namespace: monitoring
      name: alertmanager-main
      port: web

---
# Grafana Dashboard ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboards
  namespace: monitoring
  labels:
    grafana_dashboard: "1"
data:
  kubernetes-cluster.json: |
    {
      "dashboard": {
        "title": "Kubernetes Cluster Monitoring",
        "uid": "kubernetes-cluster",
        "panels": [
          {
            "title": "CPU Usage",
            "type": "graph",
            "targets": [
              {
                "expr": "sum(rate(container_cpu_usage_seconds_total[5m])) by (pod)"
              }
            ]
          },
          {
            "title": "Memory Usage",
            "type": "graph",
            "targets": [
              {
                "expr": "sum(container_memory_working_set_bytes) by (pod)"
              }
            ]
          },
          {
            "title": "Pod Count",
            "type": "stat",
            "targets": [
              {
                "expr": "count(kube_pod_info)"
              }
            ]
          }
        ]
      }
    }

---
# Alert Rules
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: alert-rules
  namespace: monitoring
spec:
  groups:
  - name: kubernetes-alerts
    rules:
    - alert: HighCPUUsage
      expr: sum(rate(container_cpu_usage_seconds_total[5m])) by (namespace, pod) > 0.8
      for: 10m
      labels:
        severity: warning
      annotations:
        summary: "High CPU usage detected"
        description: "{{ $labels.namespace }}/{{ $labels.pod }} CPU usage is above 80%"
    
    - alert: PodMemoryUsageHigh
      expr: (sum(container_memory_working_set_bytes) by (namespace, pod) / sum(container_spec_memory_limit_bytes) by (namespace, pod)) > 0.9
      for: 5m
      labels:
        severity: critical
      annotations:
        summary: "Pod memory usage is above 90%"
    
    - alert: PodNotReady
      expr: kube_pod_status_ready{condition="true"} == 0
      for: 5m
      labels:
        severity: critical
      annotations:
        summary: "Pod is not ready"
```

---

## Domain 6: Security & Compliance (10%)

### Question 12: Implement Zero Trust Security Architecture

**Answer:**

```yaml
# AWS Security Hub Configuration
resource "aws_securityhub_account" "main" {}

resource "aws_securityhub_standards_subscription" "cis" {
  standards_arn = "arn:aws:securityhub:us-east-1::standards/aws-foundational-security-best-practices/v/1.0.0"
}

resource "aws_securityhub_standards_subscription" "pci" {
  standards_arn = "arn:aws:securityhub:us-east-1::standards/pci-dss/v/3.2.1"
}

# GuardDuty Configuration
resource "aws_guardduty_detector" "main" {
  enable = true
  
  finding_publishing_frequency = "FIFTEEN_MINUTES"
  
  detector_members {
    account_id = var.member_account_id
    email      = var.member_email
  }
}

# Security Hub Integration with EventBridge
resource "aws_cloudwatch_event_rule" "security_hub" {
  name        = "security-hub-alerts"
  description = "Route Security Hub findings to SNS"
  
  event_pattern = jsonencode({
    "source" : ["aws.securityhub"],
    "detail-type" : ["AWS Security Hub Finding"]
  })
}

resource "aws_cloudwatch_event_target" "security_hub" {
  rule      = aws_cloudwatch_event_rule.security_hub.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.security_alerts.arn
}

# Vault Configuration for Secrets Management
resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "main" {
  backend         = vault_auth_backend.kubernetes.path
  kubernetes_host = "https://${aws_eks_cluster.main.endpoint}"
  token_reviewer_jwt = data.aws_eks_cluster.main.cluster_token
  issuer          = data.aws_eks_cluster.main.oidc_issuer
}

resource "vault_policy" "app" {
  name = "app-policy"
  
  policy = <<EOF
path "secret/data/app/*" {
  capabilities = ["read"]
}

path "secret/data/database/*" {
  capabilities = ["read"]
}
EOF
}

# IAM Role for Service Account (IRSA)
resource "aws_iam_role" "app_role" {
  name = "myapp-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.main.identity.oidc.issuer, "https://", "")}"
        }
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.main.identity.oidc.issuer, "https://", "")}:sub" = "system:serviceaccount:production:myapp"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_s3" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.app_s3.arn
}
```

---

## Practice Exam Questions

### Question 13: Multiple Choice
**Q:** What is the minimum number of availability zones required for high availability in AWS?

A) 1
B) 2
C) 3
D) 4

**Answer: B** - At least 2 AZs are required for high availability to ensure redundancy.

### Question 14: Multiple Choice
**Q:** Which Kubernetes object is used to ensure a minimum number of pods are always available?

A) Deployment
B) ReplicaSet
C) PodDisruptionBudget
D) HorizontalPodAutoscaler

**Answer: C** - PodDisruptionBudget ensures minimum available pods during voluntary disruptions.

### Question 15: Scenario-Based
**Q:** You need to deploy a new version of an application with zero downtime. The current version serves 100% of traffic. Design the deployment strategy.

**Answer:**
1. Use Blue-Green deployment or Canary deployment
2. Deploy new version alongside existing version
3. Gradually shift traffic (10% → 50% → 100%)
4. Monitor metrics during transition
5. If metrics degrade, rollback to previous version
6. Once 100% traffic is on new version, remove old version

---

## Answer Key

| Question | Answer |
|----------|--------|
| Q1 | Multi-cloud CI/CD with conditional deployments |
| Q2 | Blue-Green using ALB target groups |
| Q3 | GitOps with ArgoCD and Kustomize |
| Q4 | EKS with managed node groups and PDBs |
| Q5 | Istio service mesh with traffic policies |
| Q6 | Pod Security Standards, Network Policies |
| Q7 | Aurora Global DB with Route 53 failover |
| Q8 | Lambda with provisioned concurrency |
| Q9 | Terraform modules with Terragrunt |
| Q10 | Terratest for integration testing |
| Q11 | Prometheus Operator with AlertManager |
| Q12 | Security Hub, GuardDuty, Vault IRSA |
| Q13 | B (2 AZs) |
| Q14 | C (PodDisruptionBudget) |
| Q15 | Canary/Blue-Green deployment |

---

**Good luck with your DevOps Solutions Architect exam!**
