extends MarginContainer



func _on_TurnQueue_updateCards(current_playerID):
	for player_hand in get_children():
		var player_id = player_hand.playerID
		if current_playerID == player_id: 
			player_hand.show()
		else: 
			player_hand.hide()
