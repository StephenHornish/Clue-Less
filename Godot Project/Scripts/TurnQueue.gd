extends Node


class_name TurnQueue

var active_player
var active : bool = false
signal nextTurn
signal currPlayer


func initialize()-> void:
	active_player = get_child(0)
	active_player.set_active()
	activateKeyListener()
	
func play_turn() -> Node:
	active_player.set_inactive()
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	if((active_player.get_index() + 1) % Globals.numberOfPlayers == 0):
		#needs signal
		emit_signal("nextTurn")
	active_player = get_child(new_player)
	print(active_player.playID)
	active_player.set_active()
	return active_player
	


func _process(delta) -> void: 
	if(active):
		if Input.is_action_just_pressed("Up"):
			if(legal_move("Up")):
				active_player.get_child(0).move_up()
		if Input.is_action_just_pressed("Down"):
			if(legal_move("Down")):
				active_player.get_child(0).move_down()
		if Input.is_action_just_pressed("Left") :
			if(legal_move("Left")):
				active_player.get_child(0).move_left()
		if Input.is_action_just_pressed("Right") :
			if(legal_move("Right")):
				active_player.get_child(0).move_right()
		if Input.is_action_just_pressed("ui_accept"):
			active_player.get_child(0).velocity = Vector3.ZERO
			play_turn()
		if Input.is_action_just_pressed("secret_passage") :
			if(legal_move("secret_passage")):
				active_player.get_child(0).move_secret_passage()
		 
func activateKeyListener() -> void:
	active = true

#Determines if the selected move is indeed legal
func legal_move(movement : String)->bool:
	var currtile = active_player.get_tile()
	#First move is always legal and so are secret passage moves
	print(currtile)
	print(currtile.get_moveset())
	if(Globals.turn == 1 || (movement == "secret_passage" && currtile.get_moveset().has("Secret Passage"))):
		return true
	if(currtile.get_moveset().has(movement)):
		var pos = currtile.get_moveset().find(movement)
		var adjNodeList = currtile.get_adjacenet()
		var nextTile = Globals.board.get_room(adjNodeList[pos])
		for child in self.get_children():
			if(child.get_tile() == nextTile && child.get_tile().is_Hall()):
				return false
		return true
	else:
		return false
	

func _on_Character_Selection_turn_queue(player):
	add_child(player)

