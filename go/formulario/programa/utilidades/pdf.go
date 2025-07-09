package utilidades

import (
	"fmt"
	"formularioweb/programa/mensajesflash"
	"net/http"

	"github.com/jung-kurt/gofpdf"
)

func HandlePDF() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		css_mensaje, css_session := mensajesflash.RetornaMensajeFlash(w, r)
		data := map[string]string{
			"css":     css_session,
			"mensaje": css_mensaje,
		}
		if err := plantillas.ExecuteTemplate(w, "pdfpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func GenerarPDFPrueba() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		pdf := gofpdf.New(gofpdf.OrientationPortrait, "mm", "A4", "")
		pdf.AddPage()
		pdf.SetFont("Arial", "B", 16)
		pdf.Cell(40, 10, "PDF de prueba!")                                 //El ultimo es el contenido
		err := pdf.OutputFileAndClose("./recursos/pdfgenerados/hello.pdf") //ruta donde generar pdf
		if err != nil {
			msg := fmt.Sprintf("Error al generar el pdf %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades", http.StatusSeeOther)
			return
		}
		msg := "PDF generado con exito\n"
		mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
		http.Redirect(w, r, "/utilidades/pdf", http.StatusSeeOther)

	}
}
