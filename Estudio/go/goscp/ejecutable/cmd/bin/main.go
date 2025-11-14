package main

import (
	"fmt"
	"log"
	share "sharefile/internal/sharefiles"
)

func main() {
	err := share.ExecScp()
	if err != nil {
		log.Fatal(err)

	}
	fmt.Println("Files correctly send! ")
}
