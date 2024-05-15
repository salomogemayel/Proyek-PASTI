package routes

import (
	"Proyek_Undangan/pkg/controllers"

	"github.com/gorilla/mux"
)

var RegisterUndangansRoutes = func(router *mux.Router) {
	router.HandleFunc("/undangan", controllers.CreateUndangan).Methods("POST")
	router.HandleFunc("/undangan", controllers.GetUndangan).Methods("GET")
	router.HandleFunc("/undangan/{UndanganId}", controllers.GetUndanganById).Methods("GET")
	router.HandleFunc("/undangan/{UndanganId}", controllers.UpdateUndangan).Methods("PUT")
	router.HandleFunc("/undangan/{UndanganId}", controllers.DeleteUndangan).Methods("DELETE")
}
