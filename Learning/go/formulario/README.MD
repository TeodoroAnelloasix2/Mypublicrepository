# Aplicación Web: Formulario y Subida de Archivos

Una aplicación web simple pero funcional escrita en Go. Permite al usuario rellenar un formulario y subir un archivo. Los mensajes flash notifican al usuario si la operación se ha completado correctamente o si ha habido algún error.

## Características

- Formulario con campos:
  - Nombre
  - Correo electrónico
  - Contraseña
  - Género (radio button)
- Subida de archivos (imagen u otro tipo)
- Validación básica del formulario
- Almacenamiento local de archivos subidos
- Mensajes flash para mostrar errores o confirmaciones
- Estructura modular con paquetes propios

## Tecnologías

- **Backend:** Go (Golang)
- **Frontend:** HTML, Bootstrap
- **Sesiones:** `gorilla/sessions`
- **Plantillas:** `html/template`



## Uso

1. Ejecuta el servidor:
   ```bash
   go run github.com/gravityblast/fresh@latest
   ```

**Base --> DesWebPlantillas**

