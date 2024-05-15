package main

import (
	"fmt"
	"log"
	"net/http"

	"Proyek_Lokasi/pkg/routes"

	"github.com/gorilla/handlers"
	"github.com/gorilla/mux"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

func main() {
	r := mux.NewRouter()
	routes.RegisterLokasisRoutes(r)

	// Add CORS support
	allowedOrigins := handlers.AllowedOrigins([]string{"*"})
	allowedMethods := handlers.AllowedMethods([]string{"GET", "POST", "PUT", "DELETE", "OPTIONS"})
	allowedHeaders := handlers.AllowedHeaders([]string{"Content-Type", "Authorization"})

	fmt.Println("Starting Server 9070")
	log.Fatal(http.ListenAndServe(":9070", handlers.CORS(allowedOrigins, allowedMethods, allowedHeaders)(r)))
}
