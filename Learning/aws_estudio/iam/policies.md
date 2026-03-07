# IAM notes

### Policies IAM structure: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html

```json
{
  "Version":"2012-10-17", // This element specifies the version of the lenguage sintax rules 
    "Id": "My-iam-example", // Optional identifier for the policy
    "Statement": //Requiered main element for a policy 
    [   
        {
            "Sid": "1", // Statement Id, option identifier forthe policy statement.
            "Effect": "Allow", // requiered element to specifies the effect: Allow or Deny (case sensitive) 
            "Principal": { "AWS": "arn:aws:iam::123456789012:root" }, // User
            // There is another field called "NotPrincipal" and must to be used with "Principal: Deny" policy
            "Action": // Describe the specified action or actions that will be allowed or denied
            [  
                "s3:GetObject",
                "s3:PutObject",
            ],
            // there  is another field called "NotAction"
            "Resource": // This element defines the object or objects that the statement applies to. We will always use an arn to identifies a resources
            ["arn:aws:dynamodb:us-east-2:account-ID-without-hyphens:table/books_table",
            "arn:aws:dynamodb:us-east-2:account-ID-without-hyphens:table/magazines_table"],
            "Condition" : { "{condition-operator}" : { "{condition-key}" : "{condition-value}" }} // Optional block  that allow you to specify conditions for when a policy is in effect.
        }
    ]
}
```