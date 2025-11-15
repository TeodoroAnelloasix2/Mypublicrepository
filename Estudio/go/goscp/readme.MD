# Example scp with golang

### HostKeyCallBack

```golang
//Configuration of ssh.ClientConfig
HostKeyCallback: ssh.InsecureIgnoreHostKey() //This callback function does NOT check the fingerprint of the remote server
HostKeyCallback: yourfunc // We will create a function that checks the server fingerprint using the golang.org/x/crypto/ssh/knownhosts package named yourfunc
```

### Check and add server fingerprint

```shell
ssh-keygen -F server -f /path/tofile/know_hosts # Check if there is an entry (fingerprint) for the given server in the specified file
ssh-keyscan server >> /path/tofile/know_hosts # # Add an entry (fingerprint) to the file (the server is now trusted)
#We will use container to simulate a remote server
docker build -t simulateremoteserver  .  #Build image 
docker run -it  --rm --name remote1 -p 2222:22 -d simulateremoteserver:latest # Run container
scp  -vvv -i "./keydir/llavedemo1" -P 2222  test.txt  userdemo@localhost:/home/userdemo/pool # Send file
ssh-keyscan -p 2222 server >> ~/.ssh/known_hosts  # Use keyscan with simulated the server through localhost:2222
```

## Home Lab structure
```shell
tree
.
├── docker
│   └── recursos
│       ├── crearllave.sh
│       ├── Dockerfile
│       ├── keydir
│       │   ├── llavedemo1
│       │   └── llavedemo1.pub
│       └── stillalive.sh
├── ejecutable
│   ├── cmd
│   │   └── bin
│   │       └── main.go
│   ├── go.mod
│   ├── go.sum
│   ├── internal
│   │   ├── sharefiles
│   │   │   └── share.go
│   │   └── variables
│   │       └── variables.go
│   └── recursos
│       ├── file1
│       ├── file2
│       ├── keydir
│       │   ├── llavedemo1
│       │   └── llavedemo1.pub
│       └── knhostscript
└── readme.MD
```
