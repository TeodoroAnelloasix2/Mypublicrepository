# Proyecto para construir una página web con Golang

```
Ejemplo de servidor con página web en Golang.
No es algo profesional, es simplemente un ejemplo para practicar sin ningún fin comercial o profesional

```

# Preparar
**Archivo .env**
```shell
# Contenido
Srv=tuIP
Port=tuPuerto
CertFile=./certs/cert1.crt  # sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/cert1.key -out /etc/ssl/certs/cert1.crt
KeyFile=./certs/cert1.key  # Después copiar en carpeta certs del proyecto
```
**Archivo runnerr.conf**
```shell
# Ejemplo:
root: /Ruta/a/tu/programa
build_name:        runner-build
build_log:         runner-build-errors.log
valid_ext:         .go, .tpl, .tmpl, .html, .env
no_rebuild_ext:    .tpl, .tmpl, .html
ignored:           assets, tmp
build_delay:       15
colors:            1
log_color_main:    cyan
log_color_build:   yellow
log_color_runner:  green
log_color_watcher: magenta
watch_dirs: .

```
# Ejecutar

**Ponte en la raiz de proyecto y ejecuta**
```shell
#Necesitas instalar: https://pkg.go.dev/github.com/pilu/fresh
go run github.com/gravityblast/fresh@latest
```

