package main

import (
	"fmt"
	basedatos "gospy/conectarbbdd"
	"gospy/server"
	"log"
	"time"
)

var (
	rutaCert = "../recursos/certs/"
)

func main() {

	fmt.Println("Inicializando aplicacion...")
	time.Sleep(5 * time.Second)
	basedatos.Conectar()
	mx := server.CargarRutas()
	server := server.CargarServerModel()
	server.Handler = mx
	log.Fatal(server.ListenAndServeTLS(rutaCert+"gospy.crt", rutaCert+"gospy.key"))
}
