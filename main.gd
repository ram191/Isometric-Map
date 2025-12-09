extends Control
#
#func _ready() -> void:
	#await Auth.get_user_data()
	#$Camera2D/Header/Panel/Username.text = Auth.username
	#$Camera2D/Header/CoinHUD/CoinVal.text = str(Auth.balance)

func expand_menu() -> void:
	var tween = create_tween()
	tween.tween_property($Camera2D/Menu, "position:y", 0, 0.15)
	
func collapse_menu() -> void:
	var tween = create_tween()
	tween.tween_property($Camera2D/Menu, "position:y", -460, 0.15)


func _on_check_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		expand_menu()
	else:
		collapse_menu()
