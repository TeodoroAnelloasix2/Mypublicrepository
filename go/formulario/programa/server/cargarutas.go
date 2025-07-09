package server

import (
	"net/http"

	"github.com/gorilla/mux"
)

func CargarRutas() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/", HandleHome())
	router.HandleFunc("/formulario", FormularioPage())
	router.HandleFunc("/formulario/uploads", UploadsPage())
	router.HandleFunc("/uploads-form", TratarUploads())
	router.HandleFunc("/tratar-from-datos", TratarFormulario()).Methods("POST")
	router.NotFoundHandler = http.HandlerFunc(Pagina404())
	ArchivosEstaticosMux(router)
	return router
}

func ArchivosEstaticosMux(mux *mux.Router) { //Modificamos el mux directamente con su puntero

	s := http.StripPrefix("/recursos/public", http.FileServer(http.Dir("./recursos/public")))
	mux.PathPrefix("/recursos/public").Handler(s)

}
