# 🐳 Aplicación CRUD Go + MySQL Dockerizada

Esta aplicación consta de dos partes principales:

1. 🗄️ **Base de Datos MySQL**  
   Se inicializa con una tabla y algunos registros por defecto mediante un script SQL.

2. ⚙️ **Aplicación en Go**  
   Interfaz de línea de comandos con un menú interactivo que permite realizar operaciones CRUD (Crear, Leer, Actualizar y Eliminar) sobre los datos almacenados.

## 📦 Estructura del Proyecto


**MyAppMysql$ tree**
```
.
├── docker-compose.yml
├── Mysql
│   ├── dockerBBDD
│   │   ├── createtable.sql
│   │   ├── dockerfile 
│   │   └── mysql.properties
│   ├── dockerfile 
│   └── Programa
│       ├── conectar
│       │   └── con.go
│       ├── go.mod
│       ├── go.sum
│       ├── handlers
│       │   ├── agregarcliente.go
│       │   ├── listar.go
│       │   └── modificarCliente.go
│       ├── main
│       │   └── main.go
│       ├── modelos
│       │   └── modelos.go
│       └── utils
│           └── capturainput.go
└── README.md
```

# Panel principal

```
=========== MENÚ PRINCIPAL ===========
0 Para salir del programa
1 Para listar todos los empleados
2 Para listar el empleado con id especificado
3 Para agregar un nuevo cliente
4 Para modificar un cliente
======================================
```

