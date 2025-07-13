package handlers

import (
	"clase1/conectar"
	"clase1/modelos"
	"fmt"
	"log"
	"os"
)

var (
	formato = "DATE_FORMAT(fechaAlta,'%Y-%m-%d')"
)

func ListarClientes() {
	ListaClientes := modelos.Clientes{}
	sqlquery := "select id,nombre,correo,telefono," + formato + "as fechaAlta from clientes order by id desc;"
	db := conectar.Conectar()
	defer conectar.CerrarConexion(db)
	datos, err := db.Query(sqlquery)
	if err != nil {
		err = fmt.Errorf("error ejecutando query ListaEmpleados: %w", err)
		fmt.Println(err)
		os.Exit(1)
	} else {
		fmt.Println("Query ejecutada correctamente! ")
	}
	defer datos.Close()
	for datos.Next() {
		var dato = modelos.Cliente{}
		if err := datos.Scan(&dato.Id, &dato.Nombre, &dato.Correo, &dato.Telefono, &dato.FechaAlta); err != nil {
			log.Fatal(err)
		}

		ListaClientes = append(ListaClientes, dato)

	}
	for _, customer := range ListaClientes {
		fecha := string(customer.FechaAlta)
		fmt.Printf("Id: %d | Nombre: %s | Correo: %s | Telefono: %s | Fecha Alta: %s\n", customer.Id, customer.Nombre, customer.Correo, customer.Telefono, fecha)
	}

}

func ListarId(id int) {
	ListaClientes := modelos.Clientes{}
	db := conectar.Conectar()
	defer conectar.CerrarConexion(db)
	//Preparamos la consulta
	query := "select id,nombre,correo,telefono," + formato + "as fechaAlta from clientes where id=?;"

	datos, err := db.Query(query, id)

	if err != nil {
		err = fmt.Errorf("error ejecutando query ListarId: %w", err)
		fmt.Println(err)
		os.Exit(1)
	} else {
		fmt.Println("Query ejecutada correctamente! ")
	}
	defer datos.Close()
	for datos.Next() {
		var dato = modelos.Cliente{}
		if err := datos.Scan(&dato.Id, &dato.Nombre, &dato.Correo, &dato.Telefono, &dato.FechaAlta); err != nil {
			log.Fatal(err)
		}

		ListaClientes = append(ListaClientes, dato)

	}
	if len(ListaClientes) == 0 {
		fmt.Printf("No hay empleados con ID: %d\n", id)
		return
	}

	for _, customer := range ListaClientes {
		fecha := string(customer.FechaAlta)
		fmt.Printf("Id: %d | Nombre: %s | Correo: %s | Telefono: %s | Fecha Alta: %s\n", customer.Id, customer.Nombre, customer.Correo, customer.Telefono, fecha)
	}

}
