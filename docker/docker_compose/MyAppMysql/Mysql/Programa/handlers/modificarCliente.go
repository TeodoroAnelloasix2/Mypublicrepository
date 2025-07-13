package handlers

import (
	"clase1/conectar"
	"clase1/modelos"
	"context"
	"fmt"
	"log"
	"os"
	"strings"
	"time"
)

func EditaCliente(cl modelos.Cliente, id int) {
	query, args := ConstruyeConsultaEditar(cl, id)
	if query == "" {
		fmt.Println("No hay campos para actualizar")
		fmt.Println("Terminando funcion actualizar.......")
		return
	}
	ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
	defer cancel()
	db := conectar.Conectar()
	defer conectar.CerrarConexion(db)
	result, err := db.ExecContext(ctx, query, args...)
	if err != nil {
		log.Panicf("No se ha podido ejecutar la consulta a la BBDD (Editar) %v\n", err)
	}
	numRows, err := result.RowsAffected()
	if err != nil {
		fmt.Println(fmt.Errorf("error en RowsAffected en EditarCliente: %w", err))
		os.Exit(1)
	}
	if numRows == 0 {
		fmt.Println("No se ha podido modificar la entrada... Revisar")
		return
	}
	ListarId(id)

}

func ConstruyeConsultaEditar(cl modelos.Cliente, id int) (query string, args []any) {
	//query := "update clientes set nombre=?, correo=?, telefono=? where id=?;" objetivo
	args = []any{}
	listaParametrosAModificar := []string{}

	if cl.Nombre != "" {
		listaParametrosAModificar = append(listaParametrosAModificar, "nombre=?")
		args = append(args, cl.Nombre)
	}
	if cl.Correo != "" {
		listaParametrosAModificar = append(listaParametrosAModificar, "correo=?")
		args = append(args, cl.Correo)
	}
	if cl.Telefono != "" {
		listaParametrosAModificar = append(listaParametrosAModificar, "telefono=?")
		args = append(args, cl.Telefono)
	}
	if len(listaParametrosAModificar) == 0 {
		return "", nil
	}
	query = fmt.Sprintf("UPDATE clientes SET %s WHERE id=?;", strings.Join(listaParametrosAModificar, ", "))
	//fmt.Printf("La query es: %s", query)
	args = append(args, id)
	return query, args
}
