extends Control

var _player_name = ""
var _IPAddress = "127.0.0.1"
var _Port =  4242




func _on_LineEdit_text_changed(new_text):
	_player_name = new_text


func _on_Host_button_up():
	if(_player_name == ""):
		return
	Network.create_server(_player_name)
	Globals.emit_signal("instance_player",get_tree().get_network_unique_id())
	_display_board()
	
	


func _on_Join_button_up():
	if(_player_name == ""):
		print("Runs2")
		return
	if(_Port < 1000 && _Port > 9999):
		print("Runs3")
		return
	Network.DEFAULT_IP = _IPAddress
	Network.DEFAULT_PORT = _Port
	Network.connect_to_server(_player_name)
	Globals.emit_signal("instance_player",get_tree().get_network_unique_id())
	_display_board()
	

func _toggle_network_setup(visible_toggle):
	visible = visible_toggle


func _display_board()->void:
	hide()
	var SceneControl  = get_parent()
	SceneControl.get_child(1).show()
	SceneControl.get_child(2).get_child(0).show()
	


func _on_IPAddress_text_changed(new_text):
	_IPAddress = new_text


func _on_Port_text_changed(new_text):
	_Port = int(new_text)
