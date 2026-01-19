package server

import (
	"net/http"

	"github.com/gorilla/mux"
)

func CargarRutas() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/", HandleHome())
	router.HandleFunc("/home", HandleHome())
	router.HandleFunc("/cpu", HandleCpuRecursos())
	router.HandleFunc("/ram", HandleRamRecursos())
	router.NotFoundHandler = http.HandlerFunc(Pagina404())
	ArchivosEstaticosMux(router)
	return router
}

func ArchivosEstaticosMux(mux *mux.Router) { //Modificamos el mux directamente con su puntero
	s := http.StripPrefix("/recursos/public", http.FileServer(http.Dir("./recursos/public")))
	mux.PathPrefix("/recursos/public").Handler(s)
}
