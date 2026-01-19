# GOSPY

**Herramienta que monitoriza la CPU y la memoria RAM**

### 🧠 CPU

Saca la información de:
- Modelo
- Fabricante
- ID del procesador
- MHz a los que trabaja
- Tamaño de la caché
- Número de núcleos físicos de la CPU
- ID del núcleo físico que aloja el procesador lógico

### 💾 RAM

Saca la información de:
- Total  
- Memoria completamente libre (no reservada, no usada)  
- Memoria disponible restante  
- Memoria swap total  
- Memoria swap libre  
- Caché  
- Parte de la swap que se está usando  

# 🛠️ Tecnologías

###  Go
- Servidor HTTPS
- github.com/gravityblast/fresh@latest (cambios en tiempo real)
- Plantillas HTML

### JavaScript
- Chart para gráficas

### HTML y CSS
- Para la web

## Estructura
```
.
├── go.mod
├── go.sum
├── image
│   └── README
│       ├── 1752856731563.png
│       ├── 1752856968684.png
│       ├── 1752856988057.png
│       └── 1752857001935.png
├── main.go
├── package.json
├── programa
│   ├── cargarvariables
│   │   └── cargarvariables.go
│   ├── models
│   │   └── models.go
│   ├── server
│   │   ├── cargarutas.go
│   │   ├── handlers.go
│   │   └── server.go
│   └── sysinfo
│       ├── cpuinfo.go
│       └── memraminfo.go
├── README.md
├── recursos
│   ├── certs
│   │   ├── sysinfo.crt
│   │   └── sysinfo.key
│   └── public
│       ├── css
│       │   ├── cpu.css
│       │   ├── footer.css
│       │   ├── header.css
│       │   ├── home.css
│       │   └── ram.css
│       ├── images
│       │   ├── cpu2.jpeg
│       │   ├── cpugospy.png
│       │   ├── cpuimage.jpeg
│       │   ├── gopher404.jpg
│       │   ├── gopher.jpeg
│       │   ├── homegospy.png
│       │   └── ramgospy.png
│       ├── js
│       │   └── graficoram.js
│       └── templates
│           ├── cpu.html
│           ├── footer.html
│           ├── header.html
│           ├── home.html
│           ├── page404.html
│           └── ram.html
├── runner.conf
└── tmp
    └── runner-build

```
### 💡 Notas

    Este proyecto fue creado como herramienta educativa y de práctica. Está pensado para correr en entornos Linux, ya que utiliza /proc/.

![1752856731563](image/README/1752856731563.png)


# Home

![1752857001935](image/README/1752857001935.png)

# Ram

![1752856988057](image/README/1752856988057.png)

# CPU

![1752856968684](image/README/1752856968684.png)
