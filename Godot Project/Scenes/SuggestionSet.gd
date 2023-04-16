extends MarginContainer



func _on_TurnQueue_displayLocation(player):
	var Suggestion = get_node(str(get_tree().get_network_unique_id()))
	#this will need to be done away with once mutliplayer is implemented
	for suggestion in get_children():
		if player.get_player_number() == suggestion.playerID: 
			suggestion.show()
		else: 
			suggestion.hide()
	Suggestion.update_room(player)
	
