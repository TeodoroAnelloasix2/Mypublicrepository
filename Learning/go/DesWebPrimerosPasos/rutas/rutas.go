package rutas

import (
	"desweb1/handlers"

	"github.com/gorilla/mux"
)

func CargarRutas() *mux.Router {
	mux := mux.NewRouter()
	mux.HandleFunc("/", handlers.HandlerRoot())
	mux.HandleFunc("/nosotros", handlers.SobreNosotros())
	//url http://srv.com/ruta/param1/param2 formato path
	mux.HandleFunc("/parametros/{id:.*}/{slug:.*}", handlers.Parametros())

	//url http://srver.com/hola?nombre='test' formato query string
	mux.HandleFunc("/paramtrosquerystring", handlers.QueryString())
	return mux
}
