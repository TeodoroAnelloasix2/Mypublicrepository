package utilidades

import (
	"fmt"
	"formularioweb/programa/mensajesflash"
	"strings"
	"time"

	"net/http"
	"path/filepath"

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

// Pdf de prueba
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

// Pdf mas profesional

var gofpdfDir = "./recursos/"

func CargarImagFIle(imgfile string) string {
	dirImages := "public/images/"
	return filepath.Join(gofpdfDir, dirImages, imgfile)
}

func RenombrarArchivo(ext string) string {
	layout := "20060102_150405"
	hora := strings.Split(time.Now().Format(layout), " ")
	arc := strings.Join(hora, "_") + "." + ext
	return arc
}
func PdfDir() string {

	return filepath.Join(gofpdfDir, "pdfgenerados")
}

func GenerarPDFProfesional() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {

		var opt gofpdf.ImageOptions

		pdf := gofpdf.New("P", "mm", "A4", "")
		//Agregar una pagina, page 1
		pdf.AddPage()
		pdf.SetFont("Helvetica", "", 20)
		_, lineHt := pdf.GetFontSize()
		pdf.Write(lineHt, "Pdf profesional\n")
		pdf.SetFont("", "U", 0)
		linkID1 := pdf.AddLink()
		pdf.WriteLinkID(lineHt, "Pagina 2", linkID1)
		pdf.SetFont("Arial", "", 11)

		//Pagina dos
		pdf.AddPage()
		pdf.SetLink(linkID1, 0, -1)
		opt.ImageType = "png"
		pdf.ImageOptions(CargarImagFIle("gopherfly.png"), -10, 10, 30, 0, false, opt, 0, "")

		pdf.SetLeftMargin(45)
		pdf.SetFontSize(14)
		_, lineht := pdf.GetFontSize()
		htmlStr := `
	<h1>Sobre mi</h1> <br>` +

			`<p>Me gusta programar y trabajar en el mundo DevOps. Disfruto automatizar tareas y crear soluciones eficientes.</p><br>


	<p><b>Lenguajes:</b> Go, Python</p><br>

<p><b>Herramientas:</b> Jenkins, pipelines CI/CD</p>
<br>

<p>Siempre estoy aprendiendo y buscando mejorar mis habilidades tecnicas.</p><br>
` +
			`<h2>Enlace mi Linkedin :) <h2><br>
 ` +
			`<a href="https://www.linkedin.com/in/teodoro-anello-a78838257/">Mi linkedin</a><br>
Esta app utiliza go`
		html := pdf.HTMLBasicNew()
		html.Write(lineht, htmlStr)
		ext := "pdf"
		filepdf := PdfDir() + "/" + RenombrarArchivo(ext)
		err := pdf.OutputFileAndClose(filepdf)
		if err != nil {
			msg := fmt.Sprintf("Error al generar el pdf %s %v", filepdf, err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/pdf", http.StatusSeeOther)
			return
		}
		msg := fmt.Sprintf("Archvio pdf %s generado con exito", filepath.Base(filepdf))
		mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
		http.Redirect(w, r, "/utilidades/pdf", http.StatusSeeOther)
	}
}
