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

```python
import json

def my_lambda_handler(event, context):
    # TODO implement
    print(event)
    for  i in range(3):
        current_key=f"key{i+1}"
        print(f"value{i+1}={event[current_key] }")

    #raise Exception("this is  expected")

```

```sh
# Important: handler = python_file_name.function_name

7z a my-function.zip  my_function.py 

# --function-name call it as a python file
# --handler call it as a python_file.python_function
aws lambda create-function \
    --function-name my_function \
    --runtime 'python3.10' \
    --zip-file fileb://my-function.zip \  
    --handler my_function.my_lambda_handler \
    --role arn:aws:iam::123456789012:role/lambda-assumerole

# To delete function 
aws lambda delete-function --function-name 'lambda-sqs' --region us-east-1

# To get lambda info
aws lambda get-function --function-name 'my_function' 
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


## Lambda function with ALB

```python
# Pyton script
import json
def lambda_handler(event, context):
    print(event)
    return {
    "statusCode": 200,
    "statusDescription": "200 OK",
    "isBase64Encoded": False,
    "headers": {
        "Content-Type": "text/html"
    },
    "body": "<h1>Hello from Lambda!</h1>"
}
```

### Create security group
```sh
# Get vpc id 
aws ec2 describe-vpcs --max-results '1000'  | jq -r '.Vpcs[].VpcId'

aws ec2 create-security-group --group-name 'demo-lambda-alb-sg' --description 'allow http traffic' --vpc-id 'vpc-xxxxxx'

aws ec2 authorize-security-group-ingress --group-id 'sg-xxxxx' --ip-permissions '{"FromPort":80,"ToPort":80,"IpProtocol":"tcp","IpRanges":[{"CidrIp":"my_ip/32"}]}' '{"FromPort":443,"ToPort":443,"IpProtocol":"tcp","IpRanges":[{"CidrIp":"my_ip/32"}]}' 

# From anywhere-ipv4
--ip-permissions '{"FromPort":80,"ToPort":80,"IpProtocol":"tcp","IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' 

```

### Creat Target group (lambda type) 

```sh
aws elbv2 create-target-group --name 'demo-lambda-tg' --target-type lambda
```

### Add rights permissions

```sh
aws lambda add-permission \
  --function-name 'my_lambda_name' \
  --statement-id alb-invoke \
  --action lambda:InvokeFunction \
  --principal elasticloadbalancing.amazonaws.com \
  --source-arn <TG-ARN>
```

### Register lambda into target group

```sh
aws elbv2 register-targets \
  --target-group-arn <tg-arn> \
  --targets Id=<lambda-arn>

```

### Create application load balancer

```sh

# We need at least 2 subnet in two different az
# To get subnets id
aws ec2 describe-subnets --filters Name=vpc-id,Values=vpc-XXXX \
  Name=availability-zone,Values=us-east-1a,us-east-1b
 
aws ec2 describe-subnets --filters Name=vpc-id,Values=$(aws ec2 describe-vpcs --max-results '1000'  | jq -r '.Vpcs[].VpcId') \
  Name=availability-zone,Values=us-east-1a,us-east-1b  > output_subnets_us1a_us1b.json  


aws elbv2 create-load-balancer \
  --name <my-alb-name> \
  --subnets subnet-xxxx subnet-yyyy \
  --security-groups <sg-group-id> \
  --scheme 'internet-facing' \
  --type application

```

### Create listener

```sh
aws elbv2 create-listener \
  --load-balancer-arn <ALB-ARN> \
  --protocol HTTP \
  --port 80 \
  --default-actions '[{"Type":"forward","TargetGroupArn":"xx-arn-xxxx"}]'
```
