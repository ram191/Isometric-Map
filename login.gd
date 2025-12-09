extends Control

var username: String
var password: String

const HOST = "https://staging.unoseamless.com/v2"

func _ready() -> void:
	print(Auth.TOKEN_PATH)
	var token = Auth.get_token()
	if token != "":
		get_tree().change_scene_to_file("res://Main.tscn")

func _on_username_text_changed(new_text: String) -> void:
	username = new_text

func _on_password_text_changed(new_text: String) -> void:
	password = new_text
	
func _on_button_pressed() -> void:
	var http_request = HTTPRequest.new()
	
	var body = JSON.stringify({"identifier": username, "password": password})
	http_request.connect("request_completed", _on_http_request_completed) 
	
	add_child(http_request)
	
	var error = http_request.request("%s/login" % HOST, ["Content-Type: application/json"], HTTPClient.METHOD_POST, body)
	if error:
		push_error(error)

func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var token = json.data.data
	
	Auth.save_token(token)
	#print(json)
	#print(json.data)
	
