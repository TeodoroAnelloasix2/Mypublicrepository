# Scaling operations



## HPA: Horizontal Pod Autoscaling


#### Enable OIDC on the cluster 
```sh
#To allow internal cluster components to get iam permissions 
eksctl utils associate-iam-oidc-provider \
  --region eu-south-2 \
  --cluster italianodevops-cluster1 \
  --approve

```

```sh
# To add recomended pod-identity-agent
eksctl create addon --cluster=italianodevops-cluster1 --name=eks-pod-identity-agent --region eu-south-2
eksctl update addon  -f cluster-infra.yaml 
```
##### https://kubernetes.io/docs/concepts/workloads/autoscaling/horizontal-pod-autoscale/
```sh
# Install metrics server
# https://kubernetes-sigs.github.io/metrics-server/
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Hpa configuration
# https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/

```
```sh
# Create horizontal autoscale pod components (hpa)
kubectl apply -f horizontal-autoscaler-php-apache.yml

# Get hpa components
kubectl get hpa

```
#### keda: event based autoscale 
```
https://keda.sh/docs/2.19/scalers/
```


## Node group autoscaling https://docs.aws.amazon.com/eks/latest/best-practices/cas.html
#### How to scale nodes


```sh
# To create correct policy
aws iam create-policy --policy-name autoscale-cluster-node-policy --policy-document file://k8s-asg-policy.json
```
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
            "Resource": "*"
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
# Create service account and attach the autoscaler policy
eksctl create iamserviceaccount \
    --name cluster-autoscaler-account \
    --namespace kube-system \
    --cluster italianodevops-cluster1 \
    --attach-policy-arn "arn:aws:iam::281331456077:policy/autoscale-cluster-node-policy" \
    --approve \
    --override-existing-serviceaccounts

# Verify service account is succesfully created
kubectl describe sa cluster-autoscaler-account -n kube-system

```

```sh
kubectl apply -f autoscale-node.yaml
kubectl apply -f php-apache-deplyment.yaml

kubectl get nodes -L eks.amazonaws.com/nodegroup

```
```sh
# To test node autoscale config
kubectl scale deployment php-apache --replicas=25
```
```sh
eksctl delete cluster --name italianodevops-cluster1 --region eu-south-2 --disable-nodegroup-eviction
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


