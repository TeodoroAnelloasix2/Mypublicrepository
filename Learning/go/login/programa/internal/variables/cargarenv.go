package variables

import (
	"fmt"
	"log"

	"github.com/joho/godotenv"
)

func LeerEnv() {
	err := godotenv.Load()
	if err != nil {
		log.Panicln("Error al leer el archivo env, No se cargaron las variables!")
	}
	fmt.Println("Variables cargadas correctamente!")
	// fmt.Printf("DB: %s | User: %s | Pass: %s | Host: %s | Port: %s\n",
	// 	os.Getenv("dbname"),
	// 	os.Getenv("dbuser"),
	// 	os.Getenv("dbpasswd"),
	// 	os.Getenv("dbsrv"),
	// 	os.Getenv("dbport"))

}
