package main

import (
	"fmt"
	basedatos "gospy/conectarbbdd"
	"time"
)

func main() {

	fmt.Println("Inicializando aplicacion...")
	time.Sleep(5 * time.Second)
	basedatos.Conectar()
}
