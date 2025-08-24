package main

import (
	"clase1/handlers"
	"clase1/utils"
	"fmt"
	"os"
)

func main() {
	fmt.Println("Iniziando applicazione....")

	for {
		fmt.Println()
		eleccion := utils.CapturaInputMenuPrincipal()
		switch eleccion {
		case 0:
			fmt.Println()
			fmt.Println("Saliendo...")
			os.Exit(0)
		case 1:
			fmt.Println()
			handlers.ListarClientes()
		case 2:
			fmt.Println()
			id := utils.EligeId()
			handlers.ListarId(id)
		case 3:
			fmt.Println()
			NuevoCliente := utils.CapturarDatosCliente(eleccion)
			handlers.AgregaCliente(*NuevoCliente)
		case 4:
			fmt.Println()
			id := utils.EligeId()
			DatosCliente := utils.CapturarDatosCliente(eleccion)
			handlers.EditaCliente(*DatosCliente, id)
		default:
			fmt.Println()
			fmt.Println("Eleccion no valida")
		}

	}
}
