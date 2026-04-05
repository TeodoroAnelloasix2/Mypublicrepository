NODE_PRIVATE_DNS=$(kubectl get pod <pod-name> -o=jsonpath='{.spec.nodeName}')
SERVICE_NODE_PORT=$(kubectl get svc <service-name> -o=jsonpath='{.spec.ports[0].nodePort}')
NODE_PUBLIC_IP=$(aws ec2 describe-instances  --region <region> --query "Reservations[0].Instances[0].PublicIpAddress" --filters "Name=private-dns-name,Values=$NODE_PRIVATE_DNS" --output text)
SECURITY_GROUP_ID=$(aws ec2 describe-instances  --region <region> --query "Reservations[].Instances[].NetworkInterfaces[].Groups[].GroupId"  --filters "Name=private-dns-name,Values=$NODE_PRIVATE_DNS" --output text)


aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol "tcp" --port $SERVICE_NODE_PORT --cidr 0.0.0.0/0 --region eu-south-2

aws ec2 revoke-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol "tcp" --port $SERVICE_NODE_PORT --cidr 0.0.0.0/0 --region eu-south-2