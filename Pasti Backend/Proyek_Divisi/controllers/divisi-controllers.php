<?php
class RoomController {
    private $conn;
    private $table_name = "rooms";

    public $lantai;
    public $ruangan;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Read rooms
    public function read() {
        $query = "SELECT lantai, ruangan FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    // Create room
    public function create() {
        $query = "INSERT INTO " . $this->table_name . " SET lantai=:lantai, ruangan=:ruangan";
        $stmt = $this->conn->prepare($query);

        $this->lantai = htmlspecialchars(strip_tags($this->lantai));
        $this->ruangan = htmlspecialchars(strip_tags($this->ruangan));

        $stmt->bindParam(":lantai", $this->lantai);
        $stmt->bindParam(":ruangan", $this->ruangan);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    // Update room
    public function update() {
        $query = "UPDATE " . $this->table_name . " SET lantai = :lantai WHERE ruangan = :ruangan";
        $stmt = $this->conn->prepare($query);

        $this->lantai = htmlspecialchars(strip_tags($this->lantai));
        $this->ruangan = htmlspecialchars(strip_tags($this->ruangan));

        $stmt->bindParam(':lantai', $this->lantai);
        $stmt->bindParam(':ruangan', $this->ruangan);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    // Delete room
    public function delete() {
        $query = "DELETE FROM " . $this->table_name . " WHERE ruangan = :ruangan";
        $stmt = $this->conn->prepare($query);

        $this->ruangan = htmlspecialchars(strip_tags($this->ruangan));

        $stmt->bindParam(':ruangan', $this->ruangan);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
}
?>
