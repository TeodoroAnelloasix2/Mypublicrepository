package main

import (
	"log"
	"net/http"
)

func Home(w http.ResponseWriter, r *http.Request) {
	msg := "Welcome! This is my example home"
	_, err := w.Write([]byte(msg))
	if err != nil {
		log.Fatalf("error running home func: %v", err)
	}
}

func SayHello(w http.ResponseWriter, r *http.Request) {
	msg := "Hello!"
	_, err := w.Write([]byte(msg))
	if err != nil {
		log.Fatalf("error running hello func: %v", err)
	}
}

func SayBye(w http.ResponseWriter, r *http.Request) {
	msg := "Good bye"
	_, err := w.Write([]byte(msg))
	if err != nil {
		log.Fatalf("error running bye func: %v", err)
	}
}
func main() {
	http.HandleFunc("/", Home)
	http.HandleFunc("/hello", SayHello)
	http.HandleFunc("/bye", SayBye)
	log.Fatal(http.ListenAndServe(":8085", nil))

}
