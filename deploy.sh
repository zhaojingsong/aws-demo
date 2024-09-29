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
    cd app/lambda/my-lambda-function

    mkdir -p ../packages/
    zip -r ../packages/lambda-backend.zip . -x "node_modules/*"
    cd -
}

package_lambda_layer() {

    echo "Packaging Node.js dependencies..."
    cd app/lambda/my-lambda-function 

    npm install

    mkdir -p nodejs
    cp -rf node_modules nodejs/node_modules
    zip -r ../packages/nodejs.zip nodejs
    rm -rf nodejs
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
    rm -rf app/lambda/packages
    rm -rf dist
}

# Main script
main() {
    package_vue_project
    package_lambda_function
    package_lambda_layer
    apply_terraform
    clean_up
    echo "Script completed successfully."
}

# Execute the main function
main
