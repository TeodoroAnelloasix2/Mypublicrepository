package server

import (
	"net/http"
	"sysinfo/programa/sysinfo"
	"text/template"
)

var plantillas = template.Must(template.ParseGlob("./recursos/public/templates/*"))

func HandleHome() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := plantillas.ExecuteTemplate(w, "home", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func HandleCpuRecursos() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		datosCpu := sysinfo.LeerCpuInfo() //Leer datos cpu del sistema
		if err := plantillas.ExecuteTemplate(w, "cpupage", datosCpu); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}

}

func HandleRamRecursos() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		datosRam := sysinfo.LeerRamInfo() //Leer datos ram
		if err := plantillas.ExecuteTemplate(w, "rampage", datosRam); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

	}
}

func Pagina404() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := plantillas.ExecuteTemplate(w, "pagina404", nil); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}
