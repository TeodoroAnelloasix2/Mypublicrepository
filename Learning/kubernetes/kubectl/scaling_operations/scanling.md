# Scaling operations

### HPA: Horizontal Pod Autoscaling
##### https://kubernetes.io/docs/concepts/workloads/autoscaling/horizontal-pod-autoscale/
```sh
# Install metrics server
# https://kubernetes-sigs.github.io/metrics-server/
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Hpa configuration
# https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

```

### Node group autoscaling https://docs.aws.amazon.com/eks/latest/best-practices/cas.html

```json
//Create the policy with this manifest
{
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/k8s.io/cluster-autoscaler/enabled": "true",
                    "aws:ResourceTag/k8s.io/cluster-autoscaler/my-cluster": "owned"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:DescribeTags",
                "ec2:DescribeImages",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeLaunchTemplateVersions",
                "ec2:GetInstanceTypesFromInstanceRequirements",
                "eks:DescribeNodegroup"
            ],
            "Resource": "*"
        }
    ]
}
```


```sh

# Obtener el nombre del role
eksctl get iamserviceaccount --cluster italianodevops-cluster1 --region eu-south-2

ROLE_NAME=$(aws iam get-role --role-name eksctl-italianodevops-cluster1-addon-iamservi-Role1-xxxxx --query 'Role.RoleName' --output text)

# Attach the policy to existing role


aws iam attach-role-policy \
    --role-name $(eksctl get iamserviceaccount --cluster italianodevops-cluster1 --region eu-south-2 | awk '/arn:aws/ {print $NF}' | cut -d'/' -f2) \
    --policy-arn $(aws iam list-policies --query "Policies[?contains(PolicyName,'asg')]" | awk '/arn/{print $NF}' | cut -d "," -f 1 | tr -d '"')


aws iam list-attached-role-policies \
    --role-name $(eksctl get iamserviceaccount --cluster italianodevops-cluster1 --region eu-south-2 | awk '/arn:aws/ {print $NF}' | cut -d'/' -f2)



```


