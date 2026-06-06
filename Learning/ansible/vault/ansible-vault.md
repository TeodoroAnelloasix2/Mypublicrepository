# How to encrypt sensitive content

```yaml
# keys.yml (let's pretend we have to encrypt the file with this content below)
aws_password: my_password_value
dba_password: my_secret_text
```
```sh
# To encrypt
ansible-vault encrypt keys.yml
# set password
#New Vault password: 
#Confirm New Vault password: 
#Encryption successful


#To use encrypted file

ansible-vault view keys.yml 
ansible-vault view keys.yml --vault-passwrord-file=my_password.txt 
#Vault password: 
aws_password: my_password_value
dba_password: my_secret_text
 
```

```sh
# To create encrypted file from another one
ansible-vault encrypt keys.yml --output encrypted_file.yml
```

```sh
# We can create an ecnrypted file in cli
ansible-vault create encrypted.yml 
# Then we set a password and the default cli text editor will be spawned so we can fill the file  

#Edit file
ansible-vault edit encrypted.yml
```

```sh
# TO decrypt file
ansible-vault decrypt my_password.yml 
#Vault password: 
#Decryption successful

cat my_password.yml 
#password: test1
#password2: test2
#password3: edited
#password4: edited2


# Change password for encrypted 
ansible-vault rekey keys.yml 
#Vault password:                      current password
#New Vault password:                  new password
#Confirm New Vault password:          confirm
#Rekey successful

```

