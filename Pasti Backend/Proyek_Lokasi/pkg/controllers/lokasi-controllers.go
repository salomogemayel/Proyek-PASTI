package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"Proyek_Lokasi/pkg/models"
	"Proyek_Lokasi/pkg/utils"

	"github.com/gorilla/mux"
)

var NewLokasi models.Lokasi

func GetLokasi(w http.ResponseWriter, r *http.Request) {
	// Get all Lokasi
	lokasiList := models.GetAllLokasi()

	// Marshal Lokasi list into JSON format
	res, err := json.Marshal(lokasiList)
	if err != nil {
		fmt.Println("error while marshaling Lokasi list:", err)                             // Print error message for debugging
		http.Error(w, "Error while marshaling Lokasi list", http.StatusInternalServerError) // Return a 500 Internal Server Error response
		return
	}

	// Set Content-Type header to "application/json"
	w.Header().Set("Content-Type", "application/json")

	// Write JSON response to the response writer
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func GetLokasiById(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	LokasiId := vars["LokasiId"]
	ID, err := strconv.ParseInt(LokasiId, 10, 64)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid LokasiId", http.StatusBadRequest)
		return
	}
	LokasiDetails, db := models.GetLokasibyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Lokasi details:", db.Error)
		http.Error(w, "Error while fetching Lokasi details", http.StatusInternalServerError)
		return
	}
	res, err := json.Marshal(LokasiDetails)
	if err != nil {
		fmt.Println("error while marshaling Lokasi details:", err)
		http.Error(w, "Error while marshaling Lokasi details", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func CreateLokasi(w http.ResponseWriter, r *http.Request) {
	CreateLokasi := &models.Lokasi{}
	utils.ParseBody(r, CreateLokasi)
	b := CreateLokasi.CreateLokasi()
	res, _ := json.Marshal(b)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func DeleteLokasi(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	LokasiId := vars["LokasiId"]
	ID, err := strconv.ParseInt(LokasiId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid LokasiId", http.StatusBadRequest)
		return
	}
	Lokasi := models.DeleteLokasi(ID)
	res, _ := json.Marshal(Lokasi)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func UpdateLokasi(w http.ResponseWriter, r *http.Request) {
	var UpdateLokasi = &models.Lokasi{}
	utils.ParseBody(r, UpdateLokasi)
	vars := mux.Vars(r)
	LokasiId := vars["LokasiId"]
	ID, err := strconv.ParseInt(LokasiId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid LokasiId", http.StatusBadRequest)
		return
	}
	LokasiDetails, db := models.GetLokasibyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Lokasi details:", db.Error)
		http.Error(w, "Error while fetching Lokasi details", http.StatusInternalServerError)
		return
	}

	if UpdateLokasi.Ruangan != "" {
		LokasiDetails.Ruangan = UpdateLokasi.Ruangan
	}

	if UpdateLokasi.Lantai != "" {
		LokasiDetails.Lantai = UpdateLokasi.Lantai
	}

	db.Save(&LokasiDetails)
	res, _ := json.Marshal(LokasiDetails)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
