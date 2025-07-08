package main

import (
	variables "formularioweb/programa/cargarvariables"
	"formularioweb/programa/server"
	"log"
	"os"
)

func main() {
	variables.CargarVariables()
	mx := server.CargarRutas()
	server := server.CargarServerModel(15)
	server.Handler = mx
	log.Fatal(server.ListenAndServeTLS(os.Getenv("CertFile"), os.Getenv("KeyFile")))
}
