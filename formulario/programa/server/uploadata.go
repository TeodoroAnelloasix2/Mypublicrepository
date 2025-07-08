package server

import (
	"fmt"
	"formularioweb/programa/mensajesflash"
	"io"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"strings"
	"time"
)

func TratarUploads() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		file, hand, err := r.FormFile("foto")
		if err != nil {
			mensajesflash.GeneraMensajeFlash(w, r, fmt.Sprintf("1 No se pudo procesar el archivo %v", err), "danger")
			http.Redirect(w, r, "/formulario", http.StatusSeeOther)
			return

		}
		defer file.Close()
		extension := ReturnExtensionFile(hand)

		archivoRes, err := GuardarArchivo(file, RenombrarArchivo(extension))
		if err != nil {
			mensajesflash.GeneraMensajeFlash(w, r, fmt.Sprintf("2 No se pudo procesar el archivo %v", err), "danger")
			http.Redirect(w, r, "/formulario", http.StatusSeeOther)
			return
		}
		Success(w, r, archivoRes)

	}
}

func ReturnExtensionFile(file *multipart.FileHeader) string {
	var l = strings.Split(file.Filename, ".")
	return l[len(l)-1]
}

func RenombrarArchivo(ext string) string {
	layout := "20060102_150405"
	hora := strings.Split(time.Now().Format(layout), " ")
	foto := strings.Join(hora, "_") + "." + ext
	return foto
}

func GuardarArchivo(content multipart.File, arch string) (string, error) {

	archivo := "./recursos/public/images/uploads/" + arch
	f, err := os.OpenFile(archivo, os.O_WRONLY|os.O_CREATE, 0764)
	if err != nil {
		return "", fmt.Errorf("error al crear la ruta para el almacenamiento! %v", err)
	}
	defer f.Close()
	_, err = io.Copy(f, content)
	if err != nil {
		return "", fmt.Errorf("error al guardar el archivo: %v", err)
	}
	return archivo, nil
}

func Success(w http.ResponseWriter, r *http.Request, arch string) {
	a := filepath.Base(arch)
	mensajesflash.GeneraMensajeFlash(w, r, fmt.Sprintf("Archivo %s guardado", a), "success")
	http.Redirect(w, r, "/formulario", http.StatusSeeOther)

}
