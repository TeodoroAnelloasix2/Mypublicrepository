package main

import (
	"log"
	"os"
	variables "sysinfo/programa/cargarvariables"
	"sysinfo/programa/server"
)

//go run github.com/gravityblast/fresh@latest

func main() {

	variables.CargarVariables()
	mx := server.CargarRutas()
	server := server.CargarServerModel(20) //timeout 20 configuraciones
	server.Handler = mx
	log.Fatal(server.ListenAndServeTLS(os.Getenv("certcrt"), os.Getenv("certkey")))
}
