# Example scp with golang

## Home Lab for Linkedin 

### docker
```
We will use a docker  container to simulate multiple remote servers. 
Each container will generate a new fingerprint every time it is created, which allows us to test our verification.
We implemented the fingerprint change logic in the stillalive.sh file!

i've built a docker image called simulateremoteserver:latest 
```
```shell
docker build -t simulateremoteserver:latest . 
```
### ejecutable

```
Directory which contains the program source code and the final binary to execute.
To compile it
```
```shell

go build  -o goscpbin cmd/bin/main.go
```
```
It's important to run the binary from this directory because the script uses relative paths
```
### Structure

```shell
tree
.
├── docker
│   └── recursos
│       ├── crearllave.sh    <- Script to create ssh keys
│       ├── Dockerfile       <- Docker image
│       ├── keydir
│       │   ├── llavedemo1         <- ssh keys
│       │   └── llavedemo1.pub
│       └── stillalive.sh     <- The script executed when the container starts
├── ejecutable
│   ├── cmd
│   │   └── bin
│   │       └── main.go    <- Main script: manage  the scp logic
│   ├── go.mod
│   ├── go.sum
│   ├── internal
│   │   ├── sharefiles
│   │   │   └── share.go  <- Implementation of scp logic with native Go
│   │   └── variables
│   │       └── variables.go <- This script contains the variables
│   └── recursos
│       ├── file1     <-Files to send
│       ├── file2
│       ├── keydir
│       │   ├── llavedemo1  <- Private key used by the Go program
│       │   └── llavedemo1.pub
│       └── knhostscript    <- The file which contains the server's fingerprint
└── readme.MD
```

# TEST

```shell
docker run --name srvremote1  -d -it -p 2222:22  simulateremoteserver:latest 
#output:
41e4233f5d6587b1dbfda25b26f15f22e4e3c32bde76502fdd859c1f790334a4


docker ps
#Output:
CONTAINER ID   IMAGE                         COMMAND                  CREATED         STATUS         PORTS                                     NAMES
41e4233f5d65   simulateremoteserver:latest   "/bin/bash stillaliv…"   4 seconds ago   Up 3 seconds   0.0.0.0:2222->22/tcp, [::]:2222->22/tcp   srvremote1

./goscpbin
#Output:
Reading knownHost file 
File recursos/knhostscript read successfully
Reading ssh key 
File recursos/keydir/llavedemo1 read successfully
2025/11/15 23:55:56 error opening connection ssh: handshake failed: knownhosts: key mismatch


ssh-keyscan -p 2222 127.0.0.1 > recursos/knhostscript 
#Output:
# 127.0.0.1:2222 SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13
# 127.0.0.1:2222 SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13
# 127.0.0.1:2222 SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13
# 127.0.0.1:2222 SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13
# 127.0.0.1:2222 SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.13

./goscpbin
#Output:
Reading knownHost file 
File recursos/knhostscript read successfully
Reading ssh key 
File recursos/keydir/llavedemo1 read successfully

Files correctly send!   # PERFECT :) 


docker exec -it srvremote1 /bin/bash -c "ls ./pool && for a in ./pool/*; do cat \$a &&  echo "" ; done" ; echo
#Output:
file1  file2
Hello from file 1
Hello from file 2


docker stop srvremote1 && docker rm srvremote1
#Output:
srvremote1
srvremote1


docker run --name srvremote1 --rm  -d -it -p 2222:22  simulateremoteserver:latest 

#Output:
89befaa188d2b81cc7a0567b1efe0eb7827dca7c2ad62eee62cfcc449e97997b

./goscpbin
#Output:
#When we create a new container the fingerprint change so the script fail because of the verifaction
Reading knownHost file 
File recursos/knhostscript read successfully
Reading ssh key 
File recursos/keydir/llavedemo1 read successfully
2025/11/16 11:43:49 error opening connection ssh: handshake failed: knownhosts: key mismatch # As expected!

```


### HostKeyCallBack

```golang
//Configuration of ssh.ClientConfig
HostKeyCallback: ssh.InsecureIgnoreHostKey() //This callback function does NOT check the fingerprint of the remote server
HostKeyCallback: yourfunc // We will create a function, that checks the server fingerprint using the golang.org/x/crypto/ssh/knownhosts package, named yourfunc
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
