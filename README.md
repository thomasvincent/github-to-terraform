# Terraform Import Automation Script

## Overview

`terraport.sh` is a shell script designed to automate the process of importing existing GitHub resources into Terraform. This script leverages the GitHub CLI (`gh`) to list repositories and generate the necessary `terraform import` statements for various GitHub resources. It also configures the directory for Terraform Cloud.

## Prerequisites

Before running the script, ensure you have the following:

1. **GitHub CLI**: Installed and authenticated. You can install it from [GitHub CLI](https://cli.github.com/).
2. **Terraform**: Installed. You can download it from [Terraform](https://www.terraform.io/downloads.html).
3. **Environment Variables**: Set the following environment variables:
   - `GITHUB_USERNAME`: Your GitHub username.
   - `GITHUB_TOKEN`: Your GitHub personal access token.
   - `TFE_TOKEN`: Your Terraform Cloud API token.
   - `TFE_ORG`: Your Terraform Cloud organization name.
