package server

import (
	"net/http"
	"os"
	"time"
)

func CargarServerModel(timeout int) *http.Server {
	server := &http.Server{

		Addr:         os.Getenv("Srv") + ":" + os.Getenv("Port"),
		WriteTimeout: time.Duration(timeout) * time.Second,
		ReadTimeout:  time.Duration(timeout) * time.Second,
	}
	return server
}
