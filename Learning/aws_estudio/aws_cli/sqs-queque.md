# Amazon SQS

#### Create sqs 

```sh
aws sqs create-queue --queue-name 'lambda-demo-sqs' --attributes '{"DelaySeconds":"0","MaximumMessageSize":"1048576","MessageRetentionPeriod":"345600","Policy":"{\"Version\":\"2012-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__owner_statement\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"281331456077\"},\"Action\":[\"SQS:*\"],\"Resource\":\"arn:aws:sqs:us-east-1:281331456077:lambda-demo-sqs\"}]}","ReceiveMessageWaitTimeSeconds":"0","RedrivePolicy":"","VisibilityTimeout":"30","KmsMasterKeyId":"","SqsManagedSseEnabled":"true","RedriveAllowPolicy":""}' 

``` 

#### get sqs attributes

```sh
aws sqs get-queue-attributes --queue-url 'https://sqs.us-east-1.amazonaws.com/281331456077/lambda-demo-sqs' --attribute-names 'All' 
```

