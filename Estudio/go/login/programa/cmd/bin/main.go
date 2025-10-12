package main

import (
	"go-login/internal/conbbdd"
	"go-login/internal/server"
	"go-login/internal/variables"
	"log"
	"os"
)

func main() {
	variables.LeerEnv()
	crt := os.Getenv("crt")
	key := os.Getenv("key")
	srv := server.CargarServerModel()

	_ = conbbdd.Conectar() //Test conection

	log.Fatal(srv.ListenAndServeTLS(crt, key))
}
