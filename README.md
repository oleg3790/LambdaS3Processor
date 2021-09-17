## Deploying

This sample project is configured to be deployed as a zip. In order to build a deployment package you'll need the `Amazon.Lambda.Tools` .NET CLI tool. You can install it using:

```
dotnet tool install --global Amazon.Lambda.Tools
```
#### Building Payload Package
Before you can deploy the function to AWS you'll need to build the payload. Execute the `build-payload.sh` script at the root of the project to generate the payload.

After the payload has been generated, you can Terraform the infrastructure which will deploy the payload to AWS.
