package server

import (
	"formularioweb/programa/mensajesflash"
	"net/http"
	"text/template"
)

var plantillas = template.Must(template.ParseGlob("./recursos/public/templates/*"))

func Pagina404() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := plantillas.ExecuteTemplate(w, "pagina404", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}
func HandleHome() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := plantillas.ExecuteTemplate(w, "home", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func FormularioPage() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		css_mensaje, css_session := mensajesflash.RetornaMensajeFlash(w, r)
		data := map[string]string{
			"css":     css_session,
			"mensaje": css_mensaje,
		}
		if err := plantillas.ExecuteTemplate(w, "formularioget", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func UploadsPage() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := plantillas.ExecuteTemplate(w, "uploadspage", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}
