package server

import (
	"gospy/sistema"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

//Este archivo inicializa mux y carga las rutas de la pagina

func CargarRutas() *mux.Router {
	router := mux.NewRouter()
	ArchivosEstaticosMux(router)
	router.HandleFunc("/", HandleHome())
	router.HandleFunc("/home", HandleHome())
	router.HandleFunc("/previa-leer-ram-actual", sistema.PreviaRamActual()) //Ejecuta formulario para escoger medida
	router.HandleFunc("/leer-ram-actual", sistema.RamActual())              //Funcion que recibe datos para leer la ram actual
	router.HandleFunc("/guardar-datos-bbdd", sistema.GuardarDatosBBDD())
	router.HandleFunc("/cpu", sistema.ServirPaginaCpu())
	router.NotFoundHandler = http.HandlerFunc(Pagina404())

	return router
}

// Inicializar server
func CargarServerModel() *http.Server {
	timeout := 20
	server := &http.Server{
		Addr:         "gospybin:5001",
		WriteTimeout: time.Duration(timeout) * time.Second,
		ReadTimeout:  time.Duration(timeout) * time.Second,
	}

	return server
}

func ArchivosEstaticosMux(mux *mux.Router) {
	s := http.StripPrefix("/recursos/public", http.FileServer(http.Dir("/recursos/public")))
	mux.PathPrefix("/recursos/public").Handler(s)
}
