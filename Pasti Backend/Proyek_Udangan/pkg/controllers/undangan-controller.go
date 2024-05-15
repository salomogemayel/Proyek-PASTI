package controllers

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"Proyek_Undangan/pkg/models"
	"Proyek_Undangan/pkg/utils"

	"github.com/gorilla/mux"
)

var NewUndangan models.Undangan

func GetUndangan(w http.ResponseWriter, r *http.Request) {
	newUndangan := models.GetAllUndangan()
	res, _ := json.Marshal(newUndangan)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func GetUndanganById(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	UndanganId := vars["UndanganId"]
	ID, err := strconv.ParseInt(UndanganId, 10, 64)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid UndanganId", http.StatusBadRequest)
		return
	}
	UndanganDetails, db := models.GetUndanganbyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Undangan details:", db.Error)
		http.Error(w, "Error while fetching Undangan details", http.StatusInternalServerError)
		return
	}
	res, err := json.Marshal(UndanganDetails)
	if err != nil {
		fmt.Println("error while marshaling Undangan details:", err)
		http.Error(w, "Error while marshaling Undangan details", http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func CreateUndangan(w http.ResponseWriter, r *http.Request) {
	CreateUndangan := &models.Undangan{}
	utils.ParseBody(r, CreateUndangan)
	b := CreateUndangan.CreateUndangan()
	res, _ := json.Marshal(b)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func DeleteUndangan(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	UndanganId := vars["UndanganId"]
	ID, err := strconv.ParseInt(UndanganId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid UndanganId", http.StatusBadRequest)
		return
	}
	undangan := models.DeleteUndangan(ID)
	res, _ := json.Marshal(undangan)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}

func UpdateUndangan(w http.ResponseWriter, r *http.Request) {
	var UpdateUndangan = &models.Undangan{}
	utils.ParseBody(r, UpdateUndangan)
	vars := mux.Vars(r)
	UndanganId := vars["UndanganId"]
	ID, err := strconv.ParseInt(UndanganId, 0, 0)
	if err != nil {
		fmt.Println("error while parsing:", err)
		http.Error(w, "Invalid UndanganId", http.StatusBadRequest)
		return
	}
	UndanganDetails, db := models.GetUndanganbyId(ID)
	if db.Error != nil {
		fmt.Println("error while fetching Undangan details:", db.Error)
		http.Error(w, "Error while fetching Undangan details", http.StatusInternalServerError)
		return
	}

	if UpdateUndangan.Host != "" {
		UndanganDetails.Host = UpdateUndangan.Host
	}

	if UpdateUndangan.Pengunjung != "" {
		UndanganDetails.Pengunjung = UpdateUndangan.Pengunjung
	}

	if UpdateUndangan.Subjek != "" {
		UndanganDetails.Subjek = UpdateUndangan.Subjek
	}

	if UpdateUndangan.Deskripsi != "" {
		UndanganDetails.Deskripsi = UpdateUndangan.Deskripsi
	}

	if UpdateUndangan.Lokasi != "" {
		UndanganDetails.Lokasi = UpdateUndangan.Lokasi
	}

	if UpdateUndangan.Waktu != "" {
		UndanganDetails.Waktu = UpdateUndangan.Waktu
	}

	db.Save(&UndanganDetails)
	res, _ := json.Marshal(UndanganDetails)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	w.Write(res)
}
