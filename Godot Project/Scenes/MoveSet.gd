extends MarginContainer



func _on_TurnQueue_updateMoves(player,legalMoveSet):
	var moveButtons = get_node(str(get_tree().get_network_unique_id()))
	moveButtons.buildMoves(legalMoveSet)
	



func _on_TurnQueue_disableButtons(playerNumber):
	get_child(0).disableButtons()


func _on_TurnQueue_disableMoveButtons(playerNumber):
	get_node(str(get_tree().get_network_unique_id())).disableMoveButtons()
