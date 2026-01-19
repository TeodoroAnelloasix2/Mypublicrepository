package utilidades

import (
	"net/http"
	"text/template"
)

var plantillas = template.Must(template.ParseGlob("./recursos/public/templates/*"))

//var plantillas = template.Must(template.ParseGlob("./recursos/public/templates/*"))

func RecursosUtiles() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")

		if err := plantillas.ExecuteTemplate(w, "utilidadespage", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}
