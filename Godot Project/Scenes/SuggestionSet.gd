extends MarginContainer



func _on_TurnQueue_displayLocation(player):
	var Suggestion = get_node(str(get_tree().get_network_unique_id()))
	Suggestion.update_room(player)
	
