# DevOps Practical: Dockerizing and Deploying the Application with Security and Scalability

This repository provides a step-by-step guide to dockerizing the application from the [DevOps Practical GitHub repository](https://github.com/swimlane/devops-practical), deploying MongoDB as a Docker container, and deploying the application to a Kubernetes cluster using Helm charts. Additionally, it includes security and scalability enhancements.

## Prerequisites

Ensure you have the following installed on your local machine:
- Docker
- Kubernetes cluster (Minikube on AWS EC2 in this case)
- Helm (v3)
- kubectl
- Terraform
- AWS CLI

## Dockerizing the Application

**Dockerfile**
- A Dockerfile is created to containerize the application, with stages for installing dependencies and running the application.

docker build -t devops-practical:latest .

## Deploy MongoDB as a Docker Container

**Command**
- docker run -p 3000:3000 devops-practical:latest


## Creating a Kubernetes Cluster Using Terraform

Navigate to the `terraform` directory and initialize and apply the Terraform configuration.

### Directory Structure for Terraform

**main.tf**
- Contains the main configuration for provisioning the infrastructure, including VPC, subnets, security groups, EKS cluster, IAM roles, and node groups.

**outputs.tf**
- Defines the outputs for your infrastructure, such as the kubeconfig file and cluster endpoint.

**providers.tf**
- Configures the AWS and Kubernetes providers.

**variables.tf**
- Contains variables used in the Terraform configuration.

**vpc.tf**
- Defines the VPC and subnet configurations.

### Commands

1. Initialize Terraform:
        terraform init

2. Apply the Terraform configuration:
        terraform apply

### Configure kubectl

Configure `kubectl` to use the new EKS cluster:
        aws eks --region <your-region> update-kubeconfig --name eks-cluster

# Deploying the Application Using Helm

## Navigate to the `swimlane-app` Directory and Deploy the Application Using Helm

### Directory Structure for Helm

**Chart.yaml**
- Contains Helm chart metadata.

**values.yaml**
- Defines default values for the Helm chart.

**templates/_helpers.tpl**
- Placeholder for template helper functions.

**templates/deployment.yaml**
- Defines the Kubernetes deployment for the application.

**templates/hpa.yaml**
- Configures Horizontal Pod Autoscaler for automatic scaling based on CPU utilization.

**templates/mongodb-deployment.yaml**
- Defines the Kubernetes deployment for MongoDB.

**templates/mongodb-service.yaml**
- Defines the Kubernetes service for MongoDB.

**templates/networkpolicy.yaml**
- Configures network policies to control traffic between pods for better security.

**templates/service.yaml**
- Defines the Kubernetes service for the application.

### Commands

#### Deploy the application and MongoDB using Helm:
helm install devops-practical ./swimlane-app

#### Apply Horizontal Pod Autoscaler:
kubectl apply -f ./swimlane-app/templates/hpa.yaml

#### Apply Network Policy:
kubectl apply -f ./swimlane-app/templates/networkpolicy.yaml

#### Accessing the Application:
To access the application, use the NodePort or LoadBalancer service exposed by Kubernetes.


This guide provides steps to dockerize the application, deploy MongoDB as a Docker container, create a Kubernetes cluster using Minikube on AWS EC2, and deploy the application using Helm charts. It also includes security and scalability enhancements such as IAM roles for service accounts, encryption, network policies, and horizontal pod autoscaling.