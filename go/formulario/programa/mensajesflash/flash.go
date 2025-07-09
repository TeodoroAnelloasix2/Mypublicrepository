package mensajesflash

import (
	"net/http"

	gs "github.com/gorilla/sessions"
)

var s = gs.NewCookieStore([]byte("flash-session"))

func RetornaMensajeFlash(w http.ResponseWriter, r *http.Request) (string, string) {
	css_mensaje := ""
	css_session := ""
	session, err := s.Get(r, "flash-session")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return "", ""
	}

	if fm := session.Flashes("css"); len(fm) > 0 {
		css_session = fm[0].(string)
	}
	if fm2 := session.Flashes("mensaje"); len(fm2) > 0 {
		css_mensaje = fm2[0].(string)
	}
	_ = session.Save(r, w) // Solo una vez
	return css_mensaje, css_session
}

func GeneraMensajeFlash(w http.ResponseWriter, r *http.Request, mensaje string, css string) {
	session, err := s.Get(r, "flash-session")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	session.AddFlash(css, "css")
	session.AddFlash(mensaje, "mensaje")
	session.Save(r, w)

}
