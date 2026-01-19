package variables

import (
	"fmt"
	"log"

	"github.com/joho/godotenv"
)

func CargarVariables() {
	err := godotenv.Load()
	if err != nil {
		log.Panicln("Error al godotenv.Load(), No se cargaron las variables")
	} else {
		fmt.Println("Variables cargadas correctamente! ")
		//fmt.Println("Host: " + os.Getenv("dbsrv"))
	}

}
