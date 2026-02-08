# CLAUDE.md

Shell-based automation tool for importing GitHub resources into Terraform configuration.

## Purpose
Generates terraform import statements for GitHub repositories and resources using GitHub CLI.

## Prerequisites

```bash
# Verify tooling
gh --version
terraform --version

# Check environment variables
echo $GITHUB_USERNAME
echo $GITHUB_TOKEN
echo $TFE_TOKEN
echo $TFE_ORG
```

## Usage Pattern
The terraport.sh script automates:
- Listing GitHub repositories via gh CLI
- Generating terraform import commands for GitHub resources
- Configuring Terraform Cloud workspace settings
