package basedatos

import (
	"context"
	"database/sql"
	"fmt"
	vars "gospy/variables"
	"log"
	"os"
	"time"

	"github.com/go-sql-driver/mysql"
)

func CrearConfig() *mysql.Config {
	vars.CargarVariables()
	host := os.Getenv("dbsrv")
	puerto := os.Getenv("dbport")
	usuario := os.Getenv("dbuser")
	password := os.Getenv("dbpasswd")
	basedatos := os.Getenv("dbname")

	cfg := mysql.NewConfig()

	cfg.User = usuario
	cfg.Passwd = password
	cfg.Net = "tcp"
	cfg.Addr = host + ":" + puerto
	cfg.DBName = basedatos
	return cfg
}

func Conectar() *sql.DB {

	//stringconexion := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", usuario, password, host, puerto, basedatos)
	stringconexion := CrearConfig()
	db, _ := sql.Open("mysql", stringconexion.FormatDSN())

	if err := TestConexion(db); err != nil {
		err = fmt.Errorf("🛑 error al conectarse a la BBDD -> %w", err)
		log.Panicln(err)
	} else {
		fmt.Println("✅ Conexion realizada correctamente!")
	}
	BBDD := db
	return BBDD
}

// Probar conexion a la bbdd
func TestConexion(db *sql.DB) error {
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(time.Second*15))
	defer cancel()
	err := db.PingContext(ctx)
	if err != nil {
		return err
	}
	return nil
}
