# aws lambda cli commands

## Create lambda function

**steps:**
1. define a trust policy  
2. Create role  
3. Attach permissions to the role 
4. Create lambda function and use the previously created role

### 1 Define trust policy (file content)
```json
{
  "Version":"2012-10-17",		 	 	 
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}

```
### 2 Create role
```sh
aws iam create-role \
  --role-name lambda-assumerole \
  --assume-role-policy-document file://trust-policy.json
```
### 3 Add permissions 
```sh
# This permissions give at function the minimum necesary permissions to execte it self  (aws cloud watch)
aws iam attach-role-policy --role-name lambda-assumerole --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
```

### 4 Create lambda

```sh
aws lambda create-function \
    --function-name my-function \
    --runtime nodejs22.x \
    --zip-file fileb://my-function.zip \
    --handler my-function.handler \
    --role arn:aws:iam::123456789012:role/lambda-assumerole
```


## Sync
```sh
aws lambda list-functions --region us-east-1

aws lambda invoke --function-name demo-lambda --cli-binary-format raw-in-base64-out \
    --payload '{"key1":"value1","key2":"value2","key3":"value3"}' \
    --region us-east-1 \
    response.json
```

### Lambda code example runtime python 
```python
import json
def lambda_handler(event, context):
    
    body_text = f"<h1>Hello from Lambda with ALB {event.get('key1','')}</h1>"
    body_text_2 = "<h1>Hello from Lambda with ALB </h1>"
    print(json.dumps(event)) # Display logs in cloude watch
    
    return {
            "isBase64Encoded":False,
            "statusCode": 200,
            "statusDescription": "200 OK",
            "headers": {
                "Content-Type": "text/html"
                },
            "body":  body_text_2
    }
```

## Async

```sh
aws lambda invoke --function-name lambda-async --cli-binary-format raw-in-base64-out \
    --payload '{"key1":"value1","key2":"value2","key3":"value3"}' \
    --invocation-type Event --region us-east-1 response.json

```