package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"Proyek_Admin/pkg/models"
	"Proyek_Admin/pkg/utils"

	"github.com/gorilla/mux"
)

var NewAdmin models.Admin

func GetAdmin(w http.ResponseWriter, r *http.Request) {
	// Get all Admin
	adminList := models.GetAllAdmin()

	// Marshal Admin list into JSON format
	res, err := json.Marshal(adminList)
	if err != nil {
		fmt.Println("error while marshaling Admin list:", err)                             // Print error message for debugging
		http.Error(w, "Error while marshaling Admin list", http.StatusInternalServerError) // Return a 500 Internal Server Error response
		return
	}

	// Set Content-Type header to "application/json"
	w.Header().Set("Content-Type", "application/json")

	// Write JSON response to the response writer
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func GetAdminById(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	AdminId := vars["id"]
	ID, err := strconv.ParseInt(AdminId, 10, 64)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid AdminId", http.StatusBadRequest)
		return
	}
	AdminDetails, db := models.GetAdminbyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Admin details:", db.Error)
		http.Error(w, "Error while fetching Admin details", http.StatusInternalServerError)
		return
	}
	res, err := json.Marshal(AdminDetails)
	if err != nil {
		fmt.Println("error while marshaling Admin details:", err)
		http.Error(w, "Error while marshaling Admin details", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func CreateAdmin(w http.ResponseWriter, r *http.Request) {
	CreateAdmin := &models.Admin{}
	utils.ParseBody(r, CreateAdmin)
	b := CreateAdmin.CreateAdmin()
	res, _ := json.Marshal(b)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func DeleteAdmin(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	AdminId := vars["id"]
	ID, err := strconv.ParseInt(AdminId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid AdminId", http.StatusBadRequest)
		return
	}
	Admin := models.DeleteAdmin(ID)
	res, _ := json.Marshal(Admin)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func UpdateAdmin(w http.ResponseWriter, r *http.Request) {
	var UpdateAdmin = &models.Admin{}
	utils.ParseBody(r, UpdateAdmin)
	vars := mux.Vars(r)
	AdminId := vars["id"]
	ID, err := strconv.ParseInt(AdminId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid AdminId", http.StatusBadRequest)
		return
	}
	AdminDetails, db := models.GetAdminbyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Admin details:", db.Error)
		http.Error(w, "Error while fetching Admin details", http.StatusInternalServerError)
		return
	}

	if UpdateAdmin.Username != "" {
		AdminDetails.Username = UpdateAdmin.Username
	}

	if UpdateAdmin.Password != "" {
		AdminDetails.Password = UpdateAdmin.Password
	}

	if UpdateAdmin.Email != "" {
		AdminDetails.Email = UpdateAdmin.Email
	}

	if UpdateAdmin.Nama_lengkap != "" {
		AdminDetails.Nama_lengkap = UpdateAdmin.Nama_lengkap
	}

	db.Save(&AdminDetails)
	res, _ := json.Marshal(AdminDetails)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
