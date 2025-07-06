package utils

import (
	"bufio"
	"clase1/modelos"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

func leerLinea(mensaje string) string {
	fmt.Println(mensaje)
	reader := bufio.NewReader(os.Stdin)
	linea, _ := reader.ReadString('\n')
	return strings.TrimSpace(linea)
}
func CapturaInputMenuPrincipal() (Eleccion int) {

	fmt.Println("=========== MENÚ PRINCIPAL ===========")
	fmt.Println("0 Para salir del programa")
	fmt.Println("1 Para listar todos los empleados")
	fmt.Println("2 Para listar el empleado con id especificado")
	fmt.Println("3 Para agregar un nuevo cliente")
	fmt.Println("4 Para modificar un cliente")
	fmt.Println("======================================")
	fmt.Scanln(&Eleccion)
	return Eleccion
}

func EligeId() (identificador int) {

	identificador, err := strconv.Atoi(leerLinea("Elige el ID del empleado a mostrar"))
	if err != nil {
		err = fmt.Errorf("error en leer id %w", err)
		fmt.Println(err)
		os.Exit(1)
	}
	return identificador
}

func CapturarDatosCliente(eleccion int) *modelos.Cliente {
	NuevoCliente := modelos.Cliente{}
	fmt.Printf("Inserta los datos del cliente:\n")
	NuevoCliente.Nombre = leerLinea("Nombre: ")
	NuevoCliente.Correo = leerLinea("Correo: ")
	NuevoCliente.Telefono = leerLinea("Telefono: ")
	if eleccion != 4 { //Si estas agregando

		NuevoCliente.FechaAlta = time.Now().Format("2006-01-02")
		return &NuevoCliente
	}
	//Si opcion es 4 devolver directamente el cliente
	return &NuevoCliente

}
