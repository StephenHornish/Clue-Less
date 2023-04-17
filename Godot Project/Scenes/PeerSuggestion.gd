extends MarginContainer



func _on_TurnQueue_suggestionUI(_playID,_weapon,_room,_player):
	var playerID = get_node("HBoxContainer/PlayerID")
	var _text = Network.players.get(_playID.to_int()).name
	var character = get_node("HBoxContainer/Character") 
	var room = get_node("HBoxContainer/Room")
	var weapon = get_node("HBoxContainer/Weapon")
	playerID.text = _text + " suggests "
	character.text = _player + " in the "
	room.text = _room + " with the "
	weapon.text = _weapon +"!"
