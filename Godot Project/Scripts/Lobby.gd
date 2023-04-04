extends Control

var _player_name = ""

func _ready():
	Globals.connect("toggle_network_setup",self,"_toggle_network_setup")

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
	# Ignore unused return value from change_scene()
	if get_tree().change_scene("res://Scenes/PlaySpace.tscn") != OK:
		  print ("An unexpected error occured when trying to switch to the PlaySpace Scene")

func _toggle_network_setup(visible_toggle):
	visible = visible_toggle
