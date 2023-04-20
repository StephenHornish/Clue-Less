extends MarginContainer



func _on_TurnQueue_displayLocation(player,players_turn):
	var Suggestion = get_node(str(get_tree().get_network_unique_id()))
	Suggestion.update_room(player,players_turn)
	

func _on_TurnQueue_disableButtons():	
	var a = get_child(0)
	var Bbutton = a.get_node("HBoxContainer/SuggestButton")
	Bbutton.disabled = true
	var AButton = a.get_node("HBoxContainer/AccuseButton")
	AButton.disabled = true


func _on_TurnQueue_updateMoves(activePlayer, _b):
	if(activePlayer.get_tile().is_Hall()):
		return
	else:
		var a = get_child(0)
		var Bbutton = a.get_node("HBoxContainer/SuggestButton")
		Bbutton.disabled = false
		var AButton = a.get_node("HBoxContainer/AccuseButton")
		AButton.disabled = false

