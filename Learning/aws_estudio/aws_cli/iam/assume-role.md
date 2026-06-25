# Assume-role

```bash
aws sts assume-role --external-id user-id --role-arn arn:aws:iam::xxxxx:role/<role-name> --role-session-name <session-name> --serial-number arn:aws:iam::xxxxxx:mfa/<mfa_name> --token-code 123456
```

```bash
 "Credentials": {
        "AccessKeyId": "XXXXXXXXXXXXXXXXXXXXXXXx",
        "SecretAccessKey": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
        "SessionToken": "IQoJb3JpZ2luX2VjEM7//////////wEaCmV1LXNvdXRoLTEiRzBFAiXXXXXXX==",
        "Expiration": "2026-05-27T15:09:52+00:00" }

export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="XXXXXXXXXXXXXXXXXXXXXXXXXX"
export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEM7//////////wEaCmV1LXNvdXRoLTEiRzBFAiXXXXXXX=="

```bash
