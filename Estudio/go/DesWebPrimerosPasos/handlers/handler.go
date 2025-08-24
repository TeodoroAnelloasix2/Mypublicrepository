package handlers

import (
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

func HandlerRoot() func(http.ResponseWriter, *http.Request) {

	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hola Mundo, yo soy el Italiano!")
	}
}

func SobreNosotros() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Pagina sobre la empresa")
	}
}

func Parametros() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		vars := mux.Vars(r)
		fmt.Fprintf(w, "%s", "ID = "+vars["id"]+"| SLUG= "+vars["slug"])
	}
}

func QueryString() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "URL entera: %v\n", r.URL)
		fmt.Fprintf(w, "Parametros crudos: %v\n", r.URL.RawQuery)
		fmt.Fprintf(w, "Parametros en mapa: %v\n", r.URL.Query())
		fmt.Fprintf(w, "Id: %v\n", r.URL.Query().Get("id"))
		fmt.Fprintf(w, "Slug: %v\n", r.URL.Query().Get("slug"))

	}
}
