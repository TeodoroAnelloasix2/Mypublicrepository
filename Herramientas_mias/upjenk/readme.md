# App para administrar Jenkins


```
Este programa está pensado para automatizar pequeñas tareas para los sys admins que mantienen Jenkins.
```

## Nota bien! 
```
Este programa es una prueba hecha en un entorno casero.
Es un "homelab" y no funcionaría en otros entornos sin una previa adaptación.
Si quieres usarlo adelante ! :)
```

## Interfaz principal

```
All modules have been loaded successfully 
     _______________
    |_______0_______|
    |^||^||^||^||^|^| 
    |^||^||^||^||^|^| 
<<<<=================>>>>
  /                   \                  
 |    ___       ___    |
 |   |   |     |   |   |
 |   |_@_|     |_@_|   |
 |          #          | 
 \          #          /
  \         #         /
   \   ###########   /
    \  ###########  / 
     \_____________/

#         __               __   .__                                     
#        |__| ____   ____ |  | _|__| ____   ______  
#        |  |/ __ \/     \|  |/ /  |/    \ /  ___/ 
#        |  \  ___/|   |  \    <|  |   |  \___ \
#    /\__|  |\___  >___|  /__|_ \__|___|  /____ >
#    \______|    \/     \/     \/       \/    \/

WHAT IS YOUR WISH ?

0) POWEROFF
1) BACKUP OF JENKINS HOME
2) KNOW PLUGIN'S VERSION
3) UPDATE PENDING PLUGINS

```

## Funcionalidades

```
1 
BACKUP OF JENKINS HOME, Realiza una copia de seguridad del directorio .jenkins. 
Realiza un comprimido y lo deja en el directorio "securitybackup".
Antes de realizar la siguiente, borra la anterior de modo que solo se tendrá una cada vez.
securitybackup
└── jenkinshomebackup_2025-08-24-1147.tar.gz

Guarda el resultado en el archivo logs/backup_jenkinshome.log

├── logs
    ├── backup_jenkinshome.log  LOGS AQUI
    ├── bkp_plugins_logs.log
    |── starting-jenkins.log

```

```
2 
KNOW PLUGIN'S VERSION, Recorre el directorio .jenkins/plugins y guarda en un archivo HTML una tabla con el nombre del plugin y la versión que se está usando.
El directorio de trabajo es "pluginsdata".

pluginsdata
   ├── backup
   │   
   ├── pendingplugins
   ├── plugins.html   Datos AQUI
   └── uploadedplugins

```

```
3
UPDATE PENDING PLUGINS,

pluginsdata
   ├── backup
   │   
   ├── pendingplugins
   ├── plugins.html 
   └── uploadedplugins

El directorio "pluginsdata" contiene otros 3 directorios.  
Backup: Aquí el script deja una copia del archivo .jpi que contiene el plugin de Jenkins. El formato es backup,nombre,versión,archivo.jpi.  
Pendingplugins: Aquí es necesario subir todos los plugins que se quieren instalar en Jenkins.  
Uploadedplugins: Aquí es donde el script deja los plugins que se han instalado correctamente.  

El script hace un backup del plugin que se está utilizando antes de instalar la versión superior.  
Se generan unos logs que se guardan en logs/bkp_plugins_logs.log.  

Resultado:
├── logs
│   ├── backup_jenkinshome.log
│   ├── bkp_plugins_logs.log
│   |── starting-jenkins.log
│   
├── pluginsdata
│   ├── backup
│   │   ├── Docker Pipeline
│   │   │   └── 621.va_73f881d9232
│   │   │       └── docker-workflow.jpi
│   │   ├── LDAP Plugin
│   │   │   └── 780.vcb_33c9a_e4332
│   │   │       └── ldap.jpi
│   │   ├── NodeJS Plugin
│   │   │   └── 1.6.4
│   │   │       └── nodejs.jpi
│   │   └── Role-based Authorization Strategy
│   │       └── 756.v978cb_392eb_d3
│   │           └── role-strategy.jpi
│   ├── pendingplugins
│   ├── plugins.html
│   └── uploadedplugins
│       ├── docker-workflow.hpi
│       ├── ldap.hpi
│       ├── nodejs.hpi
│       └── role-strategy.hpi
```



### Estructura final

```
.
Programa

├── logs
│   ├── backup_jenkinshome.log
│   ├── bkp_plugins_logs.log
│   |── starting-jenkins.log
│   
├── pluginsdata
│   ├── backup
│   │   ├── Docker Pipeline
│   │   │   └── 621.va_73f881d9232
│   │   │       └── docker-workflow.jpi
│   │   ├── LDAP Plugin
│   │   │   └── 780.vcb_33c9a_e4332
│   │   │       └── ldap.jpi
│   │   ├── NodeJS Plugin
│   │   │   └── 1.6.4
│   │   │       └── nodejs.jpi
│   │   └── Role-based Authorization Strategy
│   │       └── 756.v978cb_392eb_d3
│   │           └── role-strategy.jpi
│   ├── pendingplugins
│   ├── plugins.html
│   └── uploadedplugins
│       ├── docker-workflow.hpi
│       ├── ldap.hpi
│       ├── nodejs.hpi
│       └── role-strategy.hpi
├── readme.md
├── securitybackup
│   └── jenkinshomebackup_2025-08-24-1147.tar.gz

Scripts principales

├── pluginsversion.sh
├── securitybackups.sh
└── upjenk.sh

```

