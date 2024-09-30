# aws-demo
A demo project to test the technical stack in AWS


# Prerequisite
## Dependency: 
 - Terraform v1.7.2
 - aws-cli/2.15.16
 - Vuejs v3.4.29
 - Typescrpt v5.4.0

# Deployment
 - Create a s3 bucket to store the tfstate file of terraform. Change corresponding configuration in the backend.tf
 - Create an custom domaine name. Change corresponding configuration in variable.tf
 - Configure credentials for programmatic access for the AWS CLI,
 - Run the script deploy.sh
