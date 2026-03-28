# kubernetes infra 

### To conect trought bastion host with ssh forwarding
```sh
eval $(ssh-agent -s)
ssh-add my_key.pem

ssh -A -i my_key.pem -J your-user@public-ip your-user@private-ip
```


#### Configure ~/.ssh/config

```javascript
Host bastion
   Hostname Public_ip_bastion
   User your-user
   IdentityFile "path/to/key.pem"
   ForwardAgent yes

Host private
    Hostname host_private_ip
    User your-user
    IdentityFile "path/to/key.pem"
    ProxyJump bastion
```
# infrastructure

```
                         🌍 Internet
                              |
                              |
                      +----------------+
                      |  Internet GW   |
                      +----------------+
                              |
                +-----------------------------+
                |           VPC               |
                |        10.0.0.0/16          |
                |                             |
                |   +---------------------+   |
                |   |   Public Subnet     |   |
                |   |   10.0.1.0/24       |   |
                |   |                     |   |
                |   |   Bastion Host      |<------  SSH from your PC
                |   |   (EC2)             |   |
                |   +----------+----------+   |
                |              |              |
                |              |              |
                |      +-------v--------+     |
                |      |  NAT Gateway   |     |
                |      +-------+--------+     |
                |              |              |
                |   +----------v----------+   |
                |   |   Private Subnet    |   |
                |   |   10.0.2.0/24       |   |
                |   |                     |   |
                |   |  k0s Nodes (EC2)    |   |
                |   |  (workers/control)  |   |
                |   +---------------------+   |
                |                             |
                +-----------------------------+

Access:
Local → Bastion → Private Nodes (SSH ProxyJump)

```

