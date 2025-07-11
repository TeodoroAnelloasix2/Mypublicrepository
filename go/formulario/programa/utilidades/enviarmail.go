package utilidades

import (
	"bytes"
	"encoding/json"
	"fmt"
	"formularioweb/programa/mensajesflash"
	"io"
	"net/http"
	"os"
)

func HandleMail() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		css_mensaje, css_session := mensajesflash.RetornaMensajeFlash(w, r)
		data := map[string]string{
			"css":     css_session,
			"mensaje": css_mensaje,
		}
		if err := plantillas.ExecuteTemplate(w, "emailpage", data); err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}
	}
}

func EnviarEmailTrap() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		asunto := r.FormValue("asunto")
		cuerpo := r.FormValue("cuerpo")

		htmlMsg := `<h1 style="color:red;font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;">` + asunto + `</h1>` + `<br>` + cuerpo

		apitoken := os.Getenv("gopycodewartoken")

		url := "https://sandbox.api.mailtrap.io/api/send/3885672"
		payload := GetPayloadEmail(asunto, htmlMsg)
		body, err := json.Marshal(payload)
		if err != nil {
			msg := fmt.Sprintf("Error al serializar datos del mail %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/email", http.StatusSeeOther)
			return
		}
		req, err := http.NewRequest("POST", url, bytes.NewBuffer(body))
		if err != nil {

			msg := fmt.Sprintf("Error durante la peticion %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/email", http.StatusSeeOther)
			return
		}
		req.Header.Set("Api-Token", apitoken)
		//req.Header.Set("Authorization", "Bearer "+apitoken)
		req.Header.Set("Content-Type", "application/json")
		client := &http.Client{}
		resp, err := client.Do(req)
		if err != nil {
			msg := fmt.Sprintf("Error durante el envio de emial %v", err)
			mensajesflash.GeneraMensajeFlash(w, r, msg, "danger")
			http.Redirect(w, r, "/utilidades/email", http.StatusSeeOther)
			return
		}
		defer resp.Body.Close()

		respuestaEmail, err := io.ReadAll(resp.Body)
		if err != nil {
			fmt.Println()
		}

		mensajesflash.GeneraMensajeFlash(w, r, string(respuestaEmail), "success")
		http.Redirect(w, r, "/utilidades/email", http.StatusSeeOther)

	}
}

func GetPayloadEmail(asunto, cuerpo string) *map[string]any {
	payload := map[string]any{
		"from": map[string]string{
			"email": "gopycodewar@gmail.com",
			"name":  "italianodev",
		},
		"to": []map[string]string{
			{
				"email": "ejemplo@gmail.com",
				"name":  "ejemplo2",
			},
			{
				"email": "ejemplo.job@gmail.com",
				"name":  "ejemplo",
			},
		},
		"subject": asunto,
		"html":    cuerpo,
	}

	return &payload
}
