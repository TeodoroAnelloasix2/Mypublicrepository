package server

import (
	"formularioweb/programa/utilidades"
	"net/http"

	"github.com/gorilla/mux"
)

func CargarRutas() *mux.Router {
	router := mux.NewRouter()
	router.HandleFunc("/", HandleHome())
	router.HandleFunc("/home", HandleHome())
	router.HandleFunc("/formulario", FormularioPage())
	router.HandleFunc("/formulario/uploads", UploadsPage())
	router.HandleFunc("/utilidades", utilidades.RecursosUtiles())
	router.HandleFunc("/utilidades/pdf", utilidades.HandlePDF())
	router.HandleFunc("/utilidades/excel", utilidades.HandleExcel())
	router.HandleFunc("/utilidades/qr", utilidades.HandleQRPage())
	router.HandleFunc("/utilidades/email", utilidades.HandleMail())
	router.HandleFunc("/generaqr", utilidades.GeneraQR())
	router.HandleFunc("/pdf-gen", utilidades.GenerarPDFPrueba())
	router.HandleFunc("/excel-gen-test", utilidades.GeneraExcelTest())
	router.HandleFunc("/excel-gen-clientes", utilidades.GeneraExcel())
	router.HandleFunc("/excel-download", utilidades.GeneraExcelNavegador())
	router.HandleFunc("/pdf-profesional", utilidades.GenerarPDFProfesional())
	router.HandleFunc("/utilidades/qr", utilidades.RecursosUtiles())
	router.HandleFunc("/uploads-form", TratarUploads())
	router.HandleFunc("/tratar-from-datos", TratarFormulario()).Methods("POST")
	router.HandleFunc("/enviar-emailtrap", utilidades.EnviarEmailTrap()).Methods("POST")
	router.NotFoundHandler = http.HandlerFunc(Pagina404())
	ArchivosEstaticosMux(router)
	return router
}

func ArchivosEstaticosMux(mux *mux.Router) { //Modificamos el mux directamente con su puntero

	s := http.StripPrefix("/recursos/public", http.FileServer(http.Dir("./recursos/public")))
	mux.PathPrefix("/recursos/public").Handler(s)

}
