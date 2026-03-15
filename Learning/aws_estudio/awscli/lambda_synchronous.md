# aws lambda cli commands


```sh
aws lambda list-functions --region us-east-1

aws lambda invoke --function-name demo-lambda --cli-binary-format raw-in-base64-out \
    --payload '{"key1":"value1","key2":"value2","key3":"value3"}' \
    --region us-east-1 \
    response.json
```

## Lambda code example runtime python 
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