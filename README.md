# README

## Overview
This repository contains Terraform configuration files and GitHub Actions workflows for deploying a Node.js application to Google Cloud Platform (GCP) Kubernetes Engine (GKE) and Heroku. The infrastructure setup includes creating a GKE cluster, deploying the Node.js application to the cluster, and deploying the application to Heroku. GitHub Actions workflows automate the build, test, and deployment processes.

## Terraform Configuration

### `providers.tf`
This file configures the Google Cloud provider with the necessary credentials and project settings. It also specifies the required provider version.

### `variables.tf`
Contains variable definitions used in the Terraform configuration, such as project ID, region, and cluster details.

### `main.tf`
Defines the resources to be provisioned, including the Google Kubernetes Engine cluster and associated configurations.

### Terraform Backend
Terraform state files are stored remotely in a Google Cloud Storage (GCS) bucket specified in `main.tf`.

## GitHub Actions Workflows

### `terraform.yml`
This workflow allows manual triggering through GitHub's workflow_dispatch event. It requires specifying the devops_tf_verb input as 'apply', 'plan', or 'destroy'.
1. Navigate to the "Actions" tab in your GitHub repository.
2. Select the 'Terraform' workflow.
3. Click on 'Run workflow' dropdown on the right side of the screen.
4. Enter the Terraform command (apply, plan, or destroy) in the devops_tf_verb field and click 'Run workflow'.

### `main.yml`
This workflow defines multiple jobs for building, testing, and deploying the application. It includes steps for setting up the environment, installing dependencies, building and testing the application, pushing Docker images to Docker Hub, deploying the application to Heroku, and deploying the application to Google Cloud Platform.

The CI/CD workflow is defined in the main.yml file in the .github/workflows directory of your repository. It comprises the following jobs:
- **Build & Test App**: Sets up a Node.js environment, installs application dependencies, and executes build and test scripts.
- **Push Images to DockerHub**: Builds a Docker image of the application and pushes it to DockerHub (runs if build and test job succeeds).
- **Deploy to Heroku**: Deploys the application to Heroku using the Docker image pushed to DockerHub (runs if push to DockerHub job succeeds).
- **Deploy to GCP**: Deploys the application to a GCP project using the Docker image pushed to DockerHub (runs if deploy to Heroku job succeeds).

To run the workflow:
1. Navigate to the "Actions" tab in your GitHub repository.
2. Select the 'CI-CD' workflow.
3. Click on 'Run workflow' dropdown on the right side of the screen.
4. Click 'Run workflow'.

## Secrets Management
Sensitive information such as credentials and API keys are stored as GitHub secrets and accessed securely within workflows. Secrets used in this repository include:
- `GCP_CREDENTIALS`: Google Cloud service account key JSON file.
- `GCP_PROJECT_ID`: Google Cloud project ID.
- `DOCKERHUB_USERNAME`: Docker Hub username.
- `DOCKERHUB_TOKEN`: Docker Hub access token.
- `HEROKU_API_KEY`: Heroku API key.
- `HEROKU_APP_NAME`: Heroku application name.
- `HEROKU_EMAIL`: Heroku account email.

To set these secrets:
1. Navigate to your GitHub repository and click on 'Settings'.
2. Click on 'Secrets' in the left sidebar.
3. Click on 'New repository secret'.
4. Enter the name and value of the secret, then click 'Add secret'.

## Usage
1. Fork or clone this repository.
2. Set up the required secrets in your GitHub repository settings.
3. Configure Terraform variables as needed in `variables.tf`.
4. Run the GitHub Actions workflows as desired to build, test, and deploy the application.

## Deployment to DockerHub, Heroku, and GCP
Refer to the specific platform instructions for deployment. You'll need to build your Docker image, push it to DockerHub, and then deploy it to Heroku and GCP.

## Conclusion
This guide outlined how to utilize the Terraform workflow for IAC and CI/CD for cluster creation and deployment, covering DockerHub, Heroku, and GCP deployment.

## Notes
- Ensure that appropriate IAM roles and permissions are assigned to the Google Cloud service account used for deployment.
- Review and adjust resource configurations according to your project requirements.
- Monitor workflow runs and logs for any errors or failures during deployment.
- Additional configuration or customization may be required based on specific project needs and environment setup.