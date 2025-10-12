package server

import (
	"crypto/tls"
	"net/http"
	"time"

	"github.com/gorilla/mux"
)

func CargarRutas() *mux.Router {

	router := mux.NewRouter()
	router.HandleFunc("/", HandleHome())
	router.HandleFunc("/seguridad/registro", SeguridadRegistro())
	router.HandleFunc("/seguridad/registropost", SeguridadRegstroPost).Methods("POST")
	router.HandleFunc("/seguridad/login", SegLogin())
	router.HandleFunc("/seguridad/loginpost", SegLoginPost()).Methods("POST")
	return router
}

func CargarServerModel() *http.Server {
	timeout := 25
	mx := CargarRutas()
	srv := &http.Server{
		Addr:         ":8089", //nombre del contenedor usado en docker compose
		WriteTimeout: time.Duration(timeout) * time.Second,
		ReadTimeout:  time.Duration(timeout) * time.Second,
		Handler:      mx,
		TLSConfig:    &tls.Config{NextProtos: []string{"http/1.1"}},
	}
	return srv
}

func ArchivosEstaticosMux(mux *mux.Router) {
	s := http.StripPrefix("/public", http.FileServer(http.Dir("/public")))
	mux.PathPrefix("/public").Handler(s)
}
