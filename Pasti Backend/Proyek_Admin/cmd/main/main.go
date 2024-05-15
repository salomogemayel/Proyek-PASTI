package main

import ( // Mengimport library yang dibutuhkan
	"Proyek_Admin/pkg/routes"
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/handlers"

	"github.com/gorilla/mux"
	_ "github.com/jinzhu/gorm/dialects/mysql"
)

func main() {
	r := mux.NewRouter()
	routes.RegisterAdminRoutes(r)

	// Add CORS support
	allowedOrigins := handlers.AllowedOrigins([]string{"*"})
	allowedMethods := handlers.AllowedMethods([]string{"GET", "POST", "PUT", "DELETE", "OPTIONS"})
	allowedHeaders := handlers.AllowedHeaders([]string{"Content-Type", "Authorization"})

	fmt.Println("Starting Server 9050")
	log.Fatal(http.ListenAndServe(":9050", handlers.CORS(allowedOrigins, allowedMethods, allowedHeaders)(r)))
}
