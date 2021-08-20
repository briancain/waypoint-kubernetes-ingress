package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func main() {
	// Each app sets this env var to differentiate between the two
	appVar := os.Getenv("WP_NODE")

	var fileServer http.Handler
	if appVar == "ONE" {
		fileServer = http.FileServer(http.Dir("./app-one"))
	} else if appVar == "TWO" {
		fileServer = http.FileServer(http.Dir("./app-two"))
	} else {
		// Show default if unset
		fileServer = http.FileServer(http.Dir("./static"))
	}

	http.Handle("/", fileServer)

	fmt.Printf("Starting server at: http://localhost:3000\n")
	if err := http.ListenAndServe(":3000", nil); err != nil {
		log.Fatal(err)
	}
}
