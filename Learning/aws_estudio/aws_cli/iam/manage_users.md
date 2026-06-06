# Create user 

## Creating administrator user

#### Using groups 
```sh
# Create an admin group:
aws iam create-group --group-name AdminGroup

# attach AdmnistratorAccess policy to the group
aws iam attach-group-policy \
    --group-name Administrators \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

aws iam create-user --user-name admin-user
aws iam add-user-to-group --user-name admin-user --group-name AdminGroup

```

```
Two Types of AWS Access

1. Console Access (Web Interface)

    Uses username + password
    Access through web browser
    URL format: https://[account-id].signin.aws.amazon.com/console
    Requires console password to be enabled for the IAM user

2. Programmatic Access (CLI/SDK)

    Traditionally used access keys (Access Key ID + Secret Access Key)
    For command line tools, scripts, and applications
    Used with AWS CLI, SDKs, APIs

```


```sh
# To allow console access
aws iam create-login-profile \
    --user-name admin-user \
    --password YourSecurePassword123! \
    --password-reset-required

# Programmatic Access (CLI/SDK)
aws iam create-access-key --user-name Bob
```


```sh
# Get user info
aws iam get-user --user-name admin-user

# Build login,url
echo "https://$( aws iam get-user --user-name devops-user | jq '.User.Arn' | cut -d ":" -f 5).signin.aws.amazon.com/console"
echo "https://$(aws sts get-caller-identity --query Account --output text).signin.aws.amazon.com/console"

# Suggested way
# Set an alias first
aws iam create-account-alias --account-alias myalias

# Then your URL becomes
echo "https://myalias.signin.aws.amazon.com/console"
```

## Set MFA

```sh
aws iam create-virtual-mfa-device --virtual-mfa-device-name "your-user-mfa" --bootstrap-method Base32StringSeed --outfile mfa.json
# Set manually account using your authenticator app
```
```json
{
    "VirtualMFADevice": {
        "SerialNumber": "arn:aws:iam::012345678:mfa/your-user-mfa"
    }
}
```
```sh
cat mfa.json 
LOF74RXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx5A6KPVXXXXXX

```
```sh
aws iam enable-mfa-device --user-name your-user --serial-number "arn:aws:iam::012345678:mfa/devops-user-mfa" --authentication-code1 123456  --authentication-code2 123456
```
```sh
aws iam list-mfa-devices --user-name your-user 
{
    "MFADevices": [
        {
            "UserName": "your-user",
            "SerialNumber": "arn:aws:iam::012345678:mfa/your-user-mfa",
            "EnableDate": "2026-06-06T08:39:07+00:00"
        }
    ]
}