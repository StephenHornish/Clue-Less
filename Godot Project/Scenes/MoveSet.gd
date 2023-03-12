extends MarginContainer



func _on_TurnQueue_updateMoves(player):
	print(player.get_player_number())
	var moveButtons = get_child(player.get_player_number())
	moveButtons.buildMoves(player.get_moveset())
	
	
	#this will need to be done away with once mutliplayer is implemented
	for moveset in get_children():
		if player.get_player_number() == moveset.playerID: 
			moveset.show()
		else: 
			moveset.hide()
	


func _on_TurnQueue_disableButtons(playerNumber):
	get_child(playerNumber).disableButtons()