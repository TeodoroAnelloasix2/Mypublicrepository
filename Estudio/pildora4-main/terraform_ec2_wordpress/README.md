# demo terraform #3 - aws instance  

Cal generar la clau amb l'script inclós primer  

```
sh genera-key-pair.sh
```

Exemple simple de terraform desglossat per crear una instància pública de ec2 amb sols canviar les variables de terraform.tfvars
- tipus de ami (amazon-ami | ubuntu-ami) (comptes assiciats: ec2-user | ubuntu )
- tipus d'instancia: t2.micro | t2.nano | t3.micro ...
- ...
