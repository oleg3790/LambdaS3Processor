Lambda configured to process object creation/removal events from S3 using SNS.

### Building Payload Package
This sample project is configured to be deployed as a zip. In order to build a deployment package you'll need the `Amazon.Lambda.Tools` .NET CLI tool. You can install it using:

```
dotnet tool install --global Amazon.Lambda.Tools
```

Before you can deploy the function to AWS you'll need to build the payload. Execute the `./build/build-payload.sh` script at the root of the project to generate the payload.

After the payload has been generated, you can Terraform the infrastructure which will deploy the payload to AWS by executing the `./build/apply-infrastructure.sh` script.

### Testing SNS message to Lambda
You can send a test message to the Lambda function using the following JSON model:

```json
{
  "Records": [
    {
      "Sns": {
        "Message": "Hello test"
      }
    }
  ]
}
```