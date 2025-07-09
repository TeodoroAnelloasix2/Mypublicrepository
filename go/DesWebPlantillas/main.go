package main

import (
	"desweb1/rutas"
	"desweb1/servermodel"
	variables "desweb1/varables"
	"log"
	"os"
)

func main() {

	variables.CargarVariables()
	mux := rutas.CargarRutas()
	server := servermodel.CargarServerModel(15)
	server.Handler = mux
	//sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/cert1.key -out /etc/ssl/certs/cert1.crt
	//log.Fatal(http.ListenAndServeTLS("192.168.0.14:8443", "./certs/cert1.crt", "./certs/cert1.key", nil))
	log.Fatal(server.ListenAndServeTLS(os.Getenv("CertFile"), os.Getenv("KeyFile")))

}
