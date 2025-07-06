package variables

import (
	"fmt"
	"log"

	"github.com/joho/godotenv"
)

func CargarVariables() {
	err := godotenv.Load()
	if err != nil {
		err = fmt.Errorf("error al cargar variables: %w", err)
		log.Fatalln(err)
	}

}
