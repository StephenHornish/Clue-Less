extends MarginContainer



func _on_TurnQueue_updateClueSheet(player):
	for clueSheet in get_children():
		if player.get_player_number() ==  clueSheet.playerID: 
			clueSheet.show()
		else: 
			clueSheet.hide()
