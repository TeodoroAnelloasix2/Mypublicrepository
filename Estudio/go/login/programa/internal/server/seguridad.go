package server

import (
	"context"
	"fmt"
	"go-login/internal/conbbdd"
	"go-login/internal/modelos"
	"go-login/internal/sessiones"
	"go-login/internal/variables"
	"net/http"
	"strconv"
	"time"

	"github.com/gorilla/sessions"
	"golang.org/x/crypto/bcrypt"
)

func SeguridadRegistro() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := variables.Plantillas.ExecuteTemplate(w, "registro", nil); err != nil {
			http.Error(w, err.Error(), http.StatusSeeOther)
		}
	}
}

func SeguridadRegstroPost(w http.ResponseWriter, r *http.Request) {

	//Logica registro ejemplo, seria ideal separar!
	bbdd := conbbdd.Conectar()
	defer bbdd.Close()
	//generar hash password
	costo := bcrypt.DefaultCost                                                       // vueltas de bcrypt
	hashPaswd, _ := bcrypt.GenerateFromPassword([]byte(r.FormValue("passwd")), costo) //Generar hash de una password
	datos := modelos.Usuario{}
	datos.Nombre = r.FormValue("nombre")
	datos.Cell = r.FormValue("cell")
	query := conbbdd.RegistrarUsuario //Query insert
	ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
	defer cancel()
	_, err := bbdd.ExecContext(ctx, query, datos.Nombre, datos.Cell, string(hashPaswd))
	if err != nil {

		fmt.Println(err)
		Redireccion(w, r)
	}
	fmt.Println("Registro creado correctamente!")
	Redireccion(w, r)

}

func SegLogin() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		if err := variables.Plantillas.ExecuteTemplate(w, "login", nil); err != nil {
			http.Error(w, err.Error(), http.StatusSeeOther)
		}
	}
}

func SegLoginPost() func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		users := modelos.Usuario{}
		db := conbbdd.Conectar()
		defer db.Close()
		query := conbbdd.LoginUsuario
		ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
		defer cancel()
		filas, err := db.QueryContext(ctx, query, r.FormValue("nombre"))

		if err != nil {
			fmt.Println(err)
			return
		}
		defer filas.Close()
		for filas.Next() {
			err := filas.Scan(&users.Id, &users.Nombre, &users.Cell, &users.Password)
			if err != nil {
				fmt.Printf("error: %v", err)
				return

			}
		}

		passwordalmacenada := users.Password
		comparacion := bcrypt.CompareHashAndPassword([]byte(passwordalmacenada), []byte(r.FormValue("passwd")))
		if comparacion != nil {
			fmt.Println(err)
			fmt.Println("Credenciales no válidas")
			http.Redirect(w, r, "https://localhost:8089/", http.StatusSeeOther)
			return
		}

		//Creamos la session
		fmt.Printf("Usuario: %s autenticado", users.Nombre)
		session, _ := sessiones.Store.Get(r, "session-login")
		session.Values["usuarioId"] = strconv.Itoa(users.Id)
		session.Values["usuarioNombre"] = users.Nombre
		session.Options = &sessions.Options{
			Path:     "/",
			MaxAge:   3600,
			HttpOnly: true,
			Secure:   true,
		}
		err = session.Save(r, w)
		if err != nil {
			http.Error(w, "Error guardando sesión", http.StatusSeeOther)
			return
		}
		http.Redirect(w, r, "https://localhost:8089/", http.StatusSeeOther)

	}
}

func Redireccion(w http.ResponseWriter, r *http.Request) {
	http.Redirect(w, r, "/", 301)
}
