package main

import (
	"net/http"
)

func corsMiddleware(handler http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Set headers to allow CORS
		w.Header().Set("Access-Control-Allow-Origin", "http://localhost:3000") // Or use "*" to allow any origin
		w.Header().Set("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, OPTIONS")
		w.Header().Set("Access-Control-Allow-Headers", "Content-Type, Authorization")

		// If it's a preflight OPTIONS request, send a 200 response without further processing
		if r.Method == "OPTIONS" {
			w.WriteHeader(http.StatusOK)
			return
		}
		// Otherwise, process the request using the handler
		handler.ServeHTTP(w, r)
	})
}
