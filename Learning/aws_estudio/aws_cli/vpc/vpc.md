# VPC 

### Get vpc info
```sh
aws ec2 describe-vpcs --query 'Vpcs[?IsDefault==`true`].VpcId ' --output text # Get default vpc id 


aws ec2 describe-vpcs --query 'Vpcs[?IsDefault==`true`].{ID:VpcId,CIDR:CidrBlock} ' --output table
--------------------------------------------
|               DescribeVpcs               |
+----------------+-------------------------+
|      CIDR      |           ID            |
+----------------+-------------------------+
|  172.31.0.0/16 |  vpc-0fbexxxxxxxxxx101  |
+----------------+-------------------------+
aws ec2 describe-vpcs --query 'Vpcs[?IsDefault==`true`].{ID:VpcId,CIDR:CidrBlock} ' --output json
[
    {
        "ID": "vpc-0fbexxxxxxxxx01",
        "CIDR": "172.31.0.0/16"
    }
]

```
