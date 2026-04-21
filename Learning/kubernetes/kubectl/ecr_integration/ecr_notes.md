## Integrate with ecr

```sh
# Create repository
aws ecr create-repository \
    --repository-name <repo-name> \
    --region <region-name>   > output.json

# Login with docker
aws ecr get-login-password --region <region-name> | \
docker login --username AWS --password-stdin \
123456789012.dkr.ecr.eu-south-2.amazonaws.com


# Build image & push

docker build -t 123456789012.dkr.ecr.eu-south-2.amazonaws.com/repo-name:version .

docker push image-name


# List images in repository
aws ecr list-images \
    --repository-name <repo-name> \
    --region region-name

# Get ecr info
aws ecr describe-repositories --region <region-name>

#Delete repo
aws ecr delete-repository \
    --repository-name repo-name \
    --force \
    --region region-name


# Set lifecycle policy (auto-delete old images)
aws ecr put-lifecycle-configuration \
    --repository-name <repo-name> \
    --lifecycle-policy-text file://lifecycle-policy.json \
    --region <region-name>
```
```json
//Delete last 10 tags
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 10 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}

```

