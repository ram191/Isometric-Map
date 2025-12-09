extends Node

const TOKEN_PATH = "user://token.dat"
const HOST = "https://staging.unoseamless.com/v2"
var username: String

var level: String
var balance: float
var bonus_balance: float

func save_token(token) -> void:
	var file = FileAccess.open(TOKEN_PATH, FileAccess.WRITE)
	if file:
		file.store_string(token)

func get_token() -> String:
	var file = FileAccess.open(TOKEN_PATH, FileAccess.READ)
	if not file:
		return ""
	
	var token = file.get_as_text()
	return token
	
func get_user_data() -> void:
	var http_request = HTTPRequest.new()	
	add_child(http_request)
	http_request.connect("request_completed", _on_get_profile_completed)
	http_request.request("%s/profile" % HOST, ["Authorization: Bearer %s" % get_token()], HTTPClient.METHOD_GET) 
	
	await http_request.request_completed
	
func _on_get_profile_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.data.data
	username = data.id
	
func update_balance() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_get_balance_completed)
	http_request.request("%s/balance" % HOST, ["Authorization: Bearer %s" % get_token()], HTTPClient.METHOD_GET) 
	
	await http_request.request_completed
	
func _on_get_balance_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var data = json.data.data
	balance = data.balance
