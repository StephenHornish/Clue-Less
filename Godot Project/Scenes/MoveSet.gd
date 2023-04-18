extends MarginContainer



func _on_TurnQueue_updateMoves(player,legalMoveSet):
	var moveButtons = get_node(str(get_tree().get_network_unique_id()))
	moveButtons.buildMoves(legalMoveSet)
	



func _on_TurnQueue_disableButtons():
	get_node(str(get_tree().get_network_unique_id())).disableButtons()


func _on_TurnQueue_disableMoveButtons():
	get_node(str(get_tree().get_network_unique_id())).disableMoveButtons()



func _on_TurnQueue_toggleEndTurn(toggle):
	get_node(str(get_tree().get_network_unique_id())).disableEndTurn(toggle)
