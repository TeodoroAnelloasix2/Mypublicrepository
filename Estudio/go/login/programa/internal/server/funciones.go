package server

import (
	"go-login/internal/variables"
	"net/http"
)

func HandleHome() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := variables.Plantillas.ExecuteTemplate(w, "home", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
		//fmt.Fprintf(w, "Hola es un test")
	}
}
