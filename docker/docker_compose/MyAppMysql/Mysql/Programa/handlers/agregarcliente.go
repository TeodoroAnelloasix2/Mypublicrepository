package handlers

import (
	"clase1/conectar"
	"clase1/modelos"
	"context"
	"fmt"
	"log"
	"math"
	"os"
	"time"
)

func AgregaCliente(cl modelos.Cliente) {
	var idcliente int
	ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
	defer cancel()

	db := conectar.Conectar()
	defer conectar.CerrarConexion(db)
	query := "INSERT INTO clientes (nombre, correo, telefono, fechaAlta) VALUES(?,?,?,?);"
	result, err := db.ExecContext(ctx, query, cl.Nombre, cl.Correo, cl.Telefono, cl.FechaAlta)
	if err != nil {
		log.Panicf("No se ha podido ejecutar la consulta a la BBDD %v\n", err)
	}
	numRows, err := result.RowsAffected()
	if err != nil {
		fmt.Println(fmt.Errorf("error en RowsAffected en AgregaCliente: %w", err))
		os.Exit(1)
	}
	if numRows == 0 {
		fmt.Println("No se ha podido agregar la entrada... Revisar")
		return
	}
	id, err := result.LastInsertId()

	if err != nil {
		fmt.Println(fmt.Errorf("error en LastInsertId %w", err))
		return
	}

	if id <= int64(math.MaxInt) && id >= int64(math.MinInt) {
		idcliente = int(id)
		ListarId(idcliente)
	} else {
		return
	}

}
