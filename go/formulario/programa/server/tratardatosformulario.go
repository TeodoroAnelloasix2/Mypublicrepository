package server

import (
	"fmt"
	"formularioweb/programa/mensajesflash"
	valid "formularioweb/programa/validardatos"
	"net/http"
	"strings"
)

func TratarFormulario() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		NombreUser := r.FormValue("nombre")
		Correo := r.FormValue("correo")
		passwd := r.FormValue("passwd")
		nom := strings.TrimSpace(NombreUser)
		var Eshombre bool
		var sexo string
		if !valid.ValidarPassword(passwd) {
			msg := "Detectada password que no respecta las condiciones minima, recuerda proteger tu cuenta!"
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/formulario", http.StatusSeeOther)
			return
		}
		if !valid.ValidarCorreo(Correo) {
			msg := "Detectado correo no valido, revisa por favor"
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/formulario", http.StatusSeeOther)
			return

		}
		if !valid.ValidarNombre(nom) {
			mensajesflash.GeneraMensajeFlash(w, r, fmt.Sprintf("El nombre '%s' no es válido", NombreUser), "danger")
			http.Redirect(w, r, "/formulario", http.StatusSeeOther)
			return
		}
		Eshombre = r.FormValue("hm") == "h"
		if Eshombre {
			sexo = "hombre"
		} else {
			sexo = "mujer"
		}
		fmt.Fprintf(w, "Test: Nombre: %s Correo: %s Password: %s y eres: %s", NombreUser, Correo, passwd, sexo)
	}
}
