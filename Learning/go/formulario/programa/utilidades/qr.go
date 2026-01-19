package utilidades

import (
	"encoding/base64"
	"fmt"
	"formularioweb/programa/mensajesflash"
	"net/http"

	qr "github.com/skip2/go-qrcode"
)

func HandleQRPage() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		css_mensaje, css_session := mensajesflash.RetornaMensajeFlash(w, r)
		data := map[string]string{
			"css":     css_session,
			"mensaje": css_mensaje,
		}
		if err := plantillas.ExecuteTemplate(w, "qrpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func GeneraQR() func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		perfilLinkedin := "https://www.linkedin.com/in/teodoro-anello-a78838257/"
		img, err := qr.Encode(perfilLinkedin, qr.Medium, 256)
		if err != nil {
			msg := fmt.Sprintf("Error al generar el codigo qr %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/qr", http.StatusSeeOther)
			return
		}
		codigoQr := base64.StdEncoding.EncodeToString(img)
		data := map[string]string{
			"qrimage": codigoQr,
		}
		if err := plantillas.ExecuteTemplate(w, "qrpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

	}

}

func GeneraQRFile() func(w http.ResponseWriter, r *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		perfilLinkedin := "https://www.linkedin.com/in/teodoro-anello-a78838257/"
		img, err := qr.Encode(perfilLinkedin, qr.Medium, 256)
		if err != nil {
			msg := fmt.Sprintf("Error al generar el codigo qr %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/qr", http.StatusSeeOther)
			return
		}
		codigoQr := base64.StdEncoding.EncodeToString(img)
		data := map[string]string{
			"qrimage": codigoQr,
		}
		if err := plantillas.ExecuteTemplate(w, "qrpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

	}

}
