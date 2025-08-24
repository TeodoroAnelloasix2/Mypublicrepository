package handlers

import (
	cargarmodelos "desweb1/cargaRecursos"
	"fmt"
	"log"
	"net/http"
	"text/template"

	"github.com/gorilla/mux"
)

func HandleHome() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		temp, err := template.ParseFiles("./templates/home/home.html")
		if err != nil {
			log.Panicf("Error parseando el template t1: %v", err)
		}
		temp.Execute(w, nil)
	}
}

func SobreNosotros() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		temp, err := template.ParseFiles("./templates/nosotros/nosotros.html")
		if err != nil {
			log.Panicf("Error parseando el template t1: %v", err)
		}
		temp.Execute(w, nil)
	}
}

func Parametros() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		temp, err := template.ParseFiles("./templates/parametros/parametros.html")
		if err != nil {
			fmt.Printf("Error al cargando la plantilla parametros: %v\n", err)
		}
		vars := mux.Vars(r)
		baseMsg := "Hola soy: "
		data := map[string]string{
			"id":      vars["id"],
			"slug":    vars["slug"],
			"basemsg": baseMsg,
		}
		temp.Execute(w, data)

	}
}

func QueryString() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {

		tmplt, err := template.ParseFiles("./templates/querystring/querystring.html")
		if err != nil {
			fmt.Printf("Error al cargando la plantilla querystring: %v\n", err)
		}

		baseMsg := "Hola soy: "
		data := map[string]string{
			"edad":    r.URL.Query().Get("edad"),
			"nombre":  r.URL.Query().Get("nombre"),
			"basemsg": baseMsg,
		}
		tmplt.Execute(w, data)

	}
}

func HandlEstrucutra() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {

		tmplt, err := template.ParseFiles("./templates/estructura/estructura.html")
		if err != nil {
			fmt.Printf("Error al cargar el template de estructura: %v\n", err)
		}

		DatosUsuario := cargarmodelos.DefinirUsuario()

		tmplt.Execute(w, DatosUsuario)
	}
}

func HandlCheatSheet() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {

		tmplt, err := template.ParseFiles("./recursos/cheatsheet/index.html")
		if err != nil {
			fmt.Printf("Error al cargar el template de estructura: %v\n", err)
		}

		tmplt.Execute(w, nil)
	}
}

func HandleCompuesta() func(http.ResponseWriter, *http.Request) {

	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		tmplt := template.Must(template.ParseFiles("./templates/compuesta/compuesta.html", "./templates/footer/footer.html", "./templates/header/header.html", "./templates/home/home.html"))
		if err := tmplt.ExecuteTemplate(w, "compuesta", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func Pagina404() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		tmplt := template.Must(template.ParseFiles("./templates/errores404/404.html"))
		if err := tmplt.ExecuteTemplate(w, "error404", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}
