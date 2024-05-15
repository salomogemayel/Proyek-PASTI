<?php
require '../config/db.php';
require '../controllers/divisi-controllers.php';

$database = new Database();
$db = $database->getConnection();
$roomController = new RoomController($db);

$requestMethod = $_SERVER["REQUEST_METHOD"];
$path = explode('/', trim($_SERVER['PATH_INFO'],'/'));

switch ($requestMethod) {
    case 'GET':
        $stmt = $roomController->read();
        $rooms = $stmt->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($rooms);
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->lantai) && !empty($data->ruangan)) {
            $roomController->lantai = $data->lantai;
            $roomController->ruangan = $data->ruangan;

            if ($roomController->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "Room created."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to create room."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Incomplete data."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->lantai) && !empty($data->ruangan)) {
            $roomController->lantai = $data->lantai;
            $roomController->ruangan = $data->ruangan;

            if ($roomController->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "Room updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update room."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Incomplete data."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        if (!empty($data->ruangan)) {
            $roomController->ruangan = $data->ruangan;

            if ($roomController->delete()) {
                http_response_code(200);
                echo json_encode(array("message" => "Room deleted."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to delete room."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Incomplete data."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
