# Ec2


### To create ec2 key-pair

```sh
# Create ec2 key-pair

aws ec2 create-key-pair \
  --key-name kube-demo \
  --key-type ed25519 \
  --query 'KeyMaterial' \
  --output text  > my_key_pair/kube-demo.pem

# Ensure the was succesfully created 

aws ec2 describe-key-pairs --key-names kube-demo --region <region>

aws ec2 describe-key-pairs  --query 'KeyPairs[?KeyName==`<keyname>`].KeyPairId' --output text --region <region>

# Delete key pair

aws ec2 delete-key-pair --key-pair-id $(aws ec2 describe-key-pairs  --query 'KeyPairs[?KeyName==`llave1`].KeyPairId' --output text) --region us-east-1
{
    "Return": true,
    "KeyPairId": "key-001858fb7e6161a0b"
}

```

### Create instance
```sh
aws ec2 create-security-group --group-name 'launch-wizard-1' --description 'launch-wizard-1 created 2026-04-05T09:34:49.685Z' --vpc-id 'vpc-0578b50fc8230528a' 
aws ec2 authorize-security-group-ingress \
 --group-id 'sg-preview-1' \
 --ip-permissions '{"IpProtocol":"tcp","FromPort":22,"ToPort":22,"IpRanges":[{"CidrIp":"77.231.113.230/32"}]}' '{"IpProtocol":"tcp","FromPort":80,"ToPort":80,"IpRanges":[{"CidrIp":"0.0.0.0/0"}]}' 

aws ec2 run-instances --image-id 'ami-0666fc3894c8795a8' \
 --instance-type 't3.micro' --key-name 'test_ec2_key_pair' \
 --user-data 'IyEvYmluL2Jhc2gKCnNldCAtZQoKeXVtIHVwZGF0ZSAteQp5dW0gaW5zdGFsbCAteSBodHRwZApzeXN0ZW1jdGwgc3RhcnQgaHR0cGQKc3lzdGVtY3RsIGVuYWJsZSBodHRwZAplY2hvICI8aDE+SG9sYSBkZXNkZSAkKGhvc3RuYW1lIC1mKSA8L2gxPiIgPiAvdmFyL3d3dy9odG1sL2luZGV4Lmh0bWw=' \
 --network-interfaces '{"AssociatePublicIpAddress":true,"DeviceIndex":0,"Groups":["sg-preview-1"]}' \
 --credit-specification '{"CpuCredits":"unlimited"}' --tag-specifications '{"ResourceType":"instance","Tags":[{"Key":"Name","Value":"test-ec2"}]}' \
 --metadata-options '{"HttpEndpoint":"enabled","HttpPutResponseHopLimit":2,"HttpTokens":"required"}' \
 --private-dns-name-options '{"HostnameType":"ip-name","EnableResourceNameDnsARecord":true,"EnableResourceNameDnsAAAARecord":false}' \
 --count '1' 

```