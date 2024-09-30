#!/bin/bash
set -e # Stop script on any error

package_vue_project() {
    echo "Packaging Lambda function..."

    mkdir -p dist && rm -rf dist/*
    cd app/front 

    npm install
    npm run lint
    npm run build
    cp -r dist/* ../../dist
    cd -
}

package_lambda_function() {
    echo "Packaging Lambda function..."
    cd app/lambda/typescript-lambda

    npm run build
    cd -
}

apply_terraform() {
    echo "Applying Terraform changes..."
    cd infra 

    terraform init
    terraform apply -auto-approve

    cd -
}

clean_up() {
    echo "Cleaning up generated files..."
    rm -rf app/lambda/typescript-lambda/dist
    rm -rf dist
}

# Main script
main() {
    package_vue_project
    package_lambda_function
    apply_terraform
    clean_up
    echo "Script completed successfully."
}

# Execute the main function
main
