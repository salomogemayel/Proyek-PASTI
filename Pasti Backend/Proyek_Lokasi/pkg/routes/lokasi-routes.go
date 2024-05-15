package routes

import (
	"Proyek_Lokasi/pkg/controllers"

	"github.com/gorilla/mux"
)

var RegisterLokasisRoutes = func(router *mux.Router) {
	router.HandleFunc("/lokasi", controllers.CreateLokasi).Methods("POST")
	router.HandleFunc("/lokasi", controllers.GetLokasi).Methods("GET")
	router.HandleFunc("/lokasi/{LokasiId}", controllers.GetLokasiById).Methods("GET")
	router.HandleFunc("/lokasi/{LokasiId}", controllers.UpdateLokasi).Methods("PUT")
	router.HandleFunc("/lokasi/{LokasiId}", controllers.DeleteLokasi).Methods("DELETE")
}
