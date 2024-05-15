package models

import (
	"Proyek_Admin/pkg/config"

	"github.com/jinzhu/gorm"
)

var db *gorm.DB

type Admin struct {
	gorm.Model
	Username     string `json:"username"`
	Password     string `json:"password"`
	Email        string `json:"string"`
	Nama_lengkap string `json:"nama_lengkap"`
}

func init() {
	config.Connect()
	db = config.GetDB()
	db.AutoMigrate(&Admin{})
}

func (b *Admin) CreateAdmin() *Admin {
	db.NewRecord(b)
	db.Create(&b)
	return b
}

func GetAllAdmin() []Admin {
	var Admin []Admin
	db.Find(&Admin)
	return Admin
}

func GetAdminbyId(id int64) (*Admin, *gorm.DB) {
	var getAdmin Admin
	db := db.Where("id=?", id).Find(&getAdmin)
	return &getAdmin, db
}

func DeleteAdmin(id int64) Admin {
	var Admin Admin
	db.Where("id=?", id).Delete(Admin)
	return Admin
}
