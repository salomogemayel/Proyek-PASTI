package models

import (
	"Proyek_Undangan/pkg/config"

	"github.com/jinzhu/gorm"
)

var db *gorm.DB

type Undangan struct {
	gorm.Model
	Host       string `json:"host"`
	Pengunjung string `json:"pengunjung"`
	Subjek     string `json:"subjek"`
	Deskripsi  string `json:"deskripsi"`
	Lokasi     string `json:"lokasi"`
	Waktu      string `json:"waktu"`
}

func init() {
	config.Connect()
	db = config.GetDB()
	db.AutoMigrate(&Undangan{})
}

func (b *Undangan) CreateUndangan() *Undangan {
	db.NewRecord(b)
	db.Create(&b)
	return b
}

func GetAllUndangan() []Undangan {
	var Undangan []Undangan
	db.Find(&Undangan)
	return Undangan
}

func GetUndanganbyId(id int64) (*Undangan, *gorm.DB) {
	var getUndangan Undangan
	db := db.Where("id=?", id).Find(&getUndangan)
	return &getUndangan, db
}

func DeleteUndangan(id int64) Undangan {
	var Undangan Undangan
	db.Where("id=?", id).Delete(Undangan)
	return Undangan
}
