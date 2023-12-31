package main

import (
	"log"
	"net/http"
	"strings"
)

// GOOD: The user-provided value is escaped before being written to the log.
func handlerGood(req *http.Request) {
	username := req.URL.Query()["username"][0]
	escapedUsername := strings.ReplaceAll(username, "\n", "")
	escapedUsername = strings.ReplaceAll(escapedUsername, "\r", "")
	log.Printf("user %s logged in.\n", escapedUsername)
}
