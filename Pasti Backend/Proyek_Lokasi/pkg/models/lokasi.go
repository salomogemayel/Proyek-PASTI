package models

import (
	"Proyek_Lokasi/pkg/config"

	"github.com/jinzhu/gorm"
)

var db *gorm.DB

type Lokasi struct {
	gorm.Model
	Lantai  string `json:"lantai"`
	Ruangan string `json:"ruangan"`
}

func init() {
	config.Connect()
	db = config.GetDB()
	db.AutoMigrate(&Lokasi{})
}

func (b *Lokasi) CreateLokasi() *Lokasi {
	db.NewRecord(b)
	db.Create(&b)
	return b
}

func GetAllLokasi() []Lokasi {
	var Lokasi []Lokasi
	db.Find(&Lokasi)
	return Lokasi
}

func GetLokasibyId(id int64) (*Lokasi, *gorm.DB) {
	var getLokasi Lokasi
	db := db.Where("id=?", id).Find(&getLokasi)
	return &getLokasi, db
}

func DeleteLokasi(id int64) Lokasi {
	var Lokasi Lokasi
	db.Where("id=?", id).Delete(Lokasi)
	return Lokasi
}
