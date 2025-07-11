package utilidades

import (
	"fmt"
	"formularioweb/programa/mensajesflash"
	"formularioweb/programa/modelos"
	"net/http"
	"path/filepath"
	"strconv"
	"time"

	exce "github.com/xuri/excelize/v2"
)

// Pagina principal
func HandleExcel() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		css_mensaje, css_session := mensajesflash.RetornaMensajeFlash(w, r)
		data := map[string]string{
			"css":     css_session,
			"mensaje": css_mensaje,
		}
		if err := plantillas.ExecuteTemplate(w, "excelpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func GeneraExcelTest() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		//Iniciar excel file
		f := exce.NewFile()
		defer func() {
			if err := f.Close(); err != nil {

				msg := fmt.Sprintf("Error al cerrar file  %v", err)
				mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
				http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
				return
			}

		}()
		hoja1 := "Hoja1"
		index, err := f.NewSheet(hoja1)
		if err != nil {
			msg := fmt.Sprintf("Error al crear el file %s  %v", hoja1, err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
			http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
			return
		}
		//Generar la fila
		f.SetCellValue(hoja1, "A1", "id")
		f.SetCellValue(hoja1, "B1", "Nombre")
		f.SetCellValue(hoja1, "C1", "Correo")
		f.SetActiveSheet(index)

		//Nombrar archivo
		ext := "xlsx"
		baseExcel := "./recursos/excelgenerados/"
		archivoexcel := baseExcel + RenombrarArchivo(ext)
		if err := f.SaveAs(archivoexcel); err != nil {
			msg := fmt.Sprintf("Error generando archivo excel %s %v", archivoexcel, err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
			return
		}
		msg := fmt.Sprintf("Archivo %s creado satisfactoriamente", filepath.Base(archivoexcel))
		mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
		http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)

	}
}

func GeneraExcel() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {

		//Datos ipoteticos de una bbdd
		cliente1 := modelos.Cliente{Id: 1, Nombre: "Italiano", Correo: "correo1@test.com"}
		cliente2 := modelos.Cliente{Id: 2, Nombre: "Americano", Correo: "correo2@test.com"}
		Clientes := modelos.Clientes{}
		Clientes = append(Clientes, cliente1, cliente2)

		//Iniciar excel file
		f := exce.NewFile()
		defer func() {
			if err := f.Close(); err != nil {

				msg := fmt.Sprintf("Error al cerrar file  %v", err)
				mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
				http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
				return
			}

		}()
		hojadatos := "Clientes1"
		index, err := f.NewSheet(hojadatos)
		if err != nil {
			msg := fmt.Sprintf("Error al crear el file %s  %v", hojadatos, err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
			http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
			return
		}
		//Cabecera archivo
		f.SetCellValue(hojadatos, "A1", "ID")
		f.SetCellValue(hojadatos, "B1", "Nombre")
		f.SetCellValue(hojadatos, "C1", "Correo")
		//Agregamos al archivo excel los datos
		for i, cliente := range Clientes {
			//Generar la fila
			num := i + 2
			fila := strconv.Itoa(num)
			f.SetCellValue(hojadatos, "A"+fila, cliente.Id)
			f.SetCellValue(hojadatos, "B"+fila, cliente.Nombre)
			f.SetCellValue(hojadatos, "C"+fila, cliente.Correo)
		}
		f.SetActiveSheet(index)

		//Nombrar archivo
		ext := "xlsx"
		baseExcel := "./recursos/excelgenerados/"
		archivoexcel := baseExcel + RenombrarArchivo(ext)
		if err := f.SaveAs(archivoexcel); err != nil {
			msg := fmt.Sprintf("Error generando archivo excel %s %v", archivoexcel, err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)
			return
		}
		msg := fmt.Sprintf("Archivo %s creado satisfactoriamente", filepath.Base(archivoexcel))
		mensajesflash.GeneraMensajeFlash(w, r, msg, "success")
		http.Redirect(w, r, "/utilidades/excel", http.StatusSeeOther)

	}
}

func GeneraExcelNavegador() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Simular datos
		clientes := []modelos.Cliente{
			{Id: 1, Nombre: "Italiano", Correo: "correo1@test.com"},
			{Id: 2, Nombre: "Americano", Correo: "correo2@test.com"},
		}

		f := exce.NewFile()
		defer f.Close()

		hojadatos := "Clientes1"
		index, err := f.NewSheet(hojadatos)
		if err != nil {
			http.Error(w, "No se pudo crear la hoja", http.StatusInternalServerError)
			return
		}

		// Cabeceras
		f.SetCellValue(hojadatos, "A1", "ID")
		f.SetCellValue(hojadatos, "B1", "Nombre")
		f.SetCellValue(hojadatos, "C1", "Correo")

		for i, cliente := range clientes {
			fila := strconv.Itoa(i + 2)
			f.SetCellValue(hojadatos, "A"+fila, cliente.Id)
			f.SetCellValue(hojadatos, "B"+fila, cliente.Nombre)
			f.SetCellValue(hojadatos, "C"+fila, cliente.Correo)
		}

		f.SetActiveSheet(index)

		// Generar nombre dinámico
		nombreArchivo := fmt.Sprintf("clientes_%s.xlsx", time.Now().Format("20060102_150405"))

		// Encabezados para descarga
		w.Header().Set("Content-Type", "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
		w.Header().Set("Content-Disposition", "attachment; filename="+nombreArchivo)
		w.Header().Set("File-Name", nombreArchivo)
		w.Header().Set("Content-Transfer-Encoding", "binary")
		w.Header().Set("Expires", "0")

		// Escribir directamente al navegador
		if err := f.Write(w); err != nil {
			http.Error(w, "No se pudo generar el archivo", http.StatusInternalServerError)
			return
		}
	}
}
