package conectar

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql"
	"github.com/joho/godotenv"
)

// Crea una conexion a la BBDD
var (
	BBDD *sql.DB
)

func Conectar() *sql.DB {
	err := godotenv.Load()
	if err != nil {
		log.Panicln("Error al godotenv.Load(), No se cargaron las variables")
	}
	db, _ := sql.Open("mysql", os.Getenv("DbUser")+":"+os.Getenv("passwd")+"@tcp("+os.Getenv("DbSrv")+":"+os.Getenv("DbPort")+")/"+os.Getenv("DbName"))

	if err := TestConexion(db); err != nil {
		err = fmt.Errorf("🛑 error al conectarse a la BBDD -> %w", err)
		log.Panicln(err)
	} else {
		fmt.Println("✅ Conexion realizada correctamente!")
	}

	BBDD = db
	return BBDD
}

// Probar la conexion
func TestConexion(db *sql.DB) error {
	//Probar conexion
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(time.Second*15))
	defer cancel()
	err := db.PingContext(ctx)
	if err != nil {
		return err
	} else {
		return nil
	}

}

// Cerrar la conexion
func CerrarConexion(BBDD *sql.DB) {
	BBDD.Close()
}
