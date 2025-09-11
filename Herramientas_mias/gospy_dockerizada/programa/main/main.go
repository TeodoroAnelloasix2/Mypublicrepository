package main

import (
	"fmt"
	basedatos "gospy/conectarbbdd"
	"net/http"
	"time"
)

func main() {

	fmt.Println("Inicializando aplicacion...")
	time.Sleep(5 * time.Second)
	basedatos.Conectar()

	http.ListenAndServe(":8080", nil)
}
