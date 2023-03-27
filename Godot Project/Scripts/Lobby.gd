extends Control

var _player_name = ""



func _on_LineEdit_text_changed(new_text):
	_player_name = new_text


func _on_Host_button_up():
	if _player_name == "":
		return
	Network.create_server(_player_name)
	_load_game()
	

func _on_Join_button_up():
	if _player_name == "":
		return 
	Network.connect_to_server(_player_name)
	_load_game()

func _load_game():
	get_tree().change_scene("res://Scenes/PlaySpace.tscn")