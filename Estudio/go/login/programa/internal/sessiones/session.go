package sessiones

import (
	"go-login/internal/variables"
	"log"
	"os"

	"github.com/gorilla/sessions"
)

var Store = CrearSessionCookie()

func CrearSessionCookie() *sessions.CookieStore {
	variables.LeerEnv()
	key := os.Getenv("sessionkey")
	if key == "" {
		log.Panicln("Error accediendo a la clave de session")
	}
	return sessions.NewCookieStore([]byte(key))
}
