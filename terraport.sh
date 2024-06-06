#!/bin/bash

# Function to check if a command succeeded
check_command() {
  if [ $? -ne 0 ]; then
    echo "Error: $1 failed."
    exit 1
  fi
}

# Function to check if a variable is set
check_variable() {
  if [ -z "$1" ]; then
    echo "Error: Required environment variable $2 is not set."
    exit 1
  fi
}

# Ensure GitHub CLI is authenticated
gh auth status > /dev/null 2>&1
check_command "GitHub CLI authentication check"

# Check if the required environment variables are set
check_variable "$GITHUB_USERNAME" "GITHUB_USERNAME"
check_variable "$GITHUB_TOKEN" "GITHUB_TOKEN"
check_variable "$TFE_TOKEN" "TFE_TOKEN"
check_variable "$TFE_ORG" "TFE_ORG"

# Set up the Terraform Cloud configuration
cat <<EOF > main.tf
terraform {
  cloud {
    organization = "$TFE_ORG"

    workspaces {
      name = "default"
    }
  }
}

provider "github" {
  token = "$GITHUB_TOKEN"
}
EOF

# Initialize Terraform
terraform init
check_command "Terraform initialization"

# Function to generate Terraform import statements
generate_import_statements() {
  local repo=$1
  local username=$2

  cat <<EOF
terraform import github_repository.$repo $username/$repo
terraform import github_branch.$repo $username/$repo:main
terraform import github_branch_default.$repo $username/$repo:main
terraform import github_branch_protection.$repo $username/$repo:main
terraform import github_branch_protection_v3.$repo $username/$repo:main
terraform import github_repository_file.$repo $username/$repo:path/to/file
terraform import github_repository_webhook.$repo $username/$repo:webhook_id
terraform import github_repository_collaborator.$repo $username/$repo:username
terraform import github_repository_deploy_key.$repo $username/$repo:key_id
terraform import github_repository_environment.$repo $username/$repo:environment
terraform import github_repository_milestone.$repo $username/$repo:number
terraform import github_repository_project.$repo $username/$repo:name
terraform import github_repository_pull_request.$repo $username/$repo:number
terraform import github_repository_tag_protection.$repo $username/$repo:pattern
terraform import github_repository_topics.$repo $username/$repo
terraform import github_team.$repo $username/$repo:slug
terraform import github_team_membership.$repo $username/$repo:username
terraform import github_team_repository.$repo $username/$repo:repository
terraform import github_team_settings.$repo $username/$repo:team_id
terraform import github_user_gpg_key.$repo $username/$repo:key_id
terraform import github_user_ssh_key.$repo $username/$repo:key_id
EOF
}

# List of repositories
repos=(
  "github-to-terraform"
  "terraform-cloudflare-maintenance"
  "dotfiles-personal"
  "performance-optimization-scripts"
  "personal-portfolio"
  "pagerduty-python-client"
  "chef-zabbix-cookbook"
  "docker-wordpress-swarm-setup"
  "utility-scripts-collection"
  "snmp-bind9-statistics"
  "cloudflare-ufw-sync"
  "Spring4Shell-resources"
  "commitkit-rust"
  "relenz-infrastructure"
  "python-network-discovery-tool"
  "terraform-config"
  "terraform-aws-dedicated-host-"
  "macos-jira-github-integration-shortcut"
  "jenkins-script-library"
  "github-community-standards"
  "confd"
  "chef-snmp-cookbook"
  "atlas-management-system"
  "zenoss-puppet-module"
  "terraform-kubernetes-installer"
  "serverless-jenkins-on-aws-fargate"
  "personal-blog-site"
  "payeezy-integration-tests"
  "pausatf-main-repo"
  "oracle-inventory-management-tool"
)

# Generate import statements for each repository
for repo in "${repos[@]}"; do
  generate_import_statements $repo $GITHUB_USERNAME
done > import.sh

# Make the import script executable
chmod +x import.sh

# Run the import script
./import.sh
check_command "Running import script"

echo "Terraform import process completed successfully."
