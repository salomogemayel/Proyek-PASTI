package routes

import (
	"Proyek_Admin/pkg/controllers"

	"github.com/gorilla/mux"
)

var RegisterAdminRoutes = func(router *mux.Router) {
	router.HandleFunc("/admin", controllers.CreateAdmin).Methods("POST")
	router.HandleFunc("/admin", controllers.GetAdmin).Methods("GET")
	router.HandleFunc("/admin/{id}", controllers.GetAdminById).Methods("GET")
	router.HandleFunc("/admin/{id}", controllers.UpdateAdmin).Methods("PUT")
	router.HandleFunc("/admin/{id}", controllers.DeleteAdmin).Methods("DELETE")
}
