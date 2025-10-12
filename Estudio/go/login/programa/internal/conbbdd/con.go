package conbbdd

import (
	"context"
	"database/sql"
	"fmt"
	"go-login/internal/variables"
	"log"
	"net"
	"os"
	"time"

	"github.com/go-sql-driver/mysql"
)

func CrearConfig() (cfg *mysql.Config) {
	variables.LeerEnv()
	dbsrv := os.Getenv("dbsrv")
	dbname := os.Getenv("dbname")
	dbuser := os.Getenv("dbuser")
	dbpasswd := os.Getenv("dbpasswd")
	dbport := os.Getenv("dbport")
	cfg = mysql.NewConfig()

	cfg.User = dbuser
	cfg.Addr = net.JoinHostPort(dbsrv, dbport)
	cfg.Net = "tcp"
	cfg.Passwd = dbpasswd
	cfg.DBName = dbname
	return
}

func Conectar() *sql.DB {
	config := CrearConfig()
	db, _ := sql.Open("mysql", config.FormatDSN())

	for i := range 5 {
		if err := TestDBCon(db); err != nil && i == 4 {
			log.Panicln(fmt.Errorf("error realizando conexion bbdd -> %w", err))
		}
		time.Sleep(5 * time.Second)
	}

	return db
}

func TestDBCon(db *sql.DB) error {
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(25*time.Second))
	defer cancel()
	err := db.PingContext(ctx)
	if err != nil {
		return err
	}
	return nil
}
