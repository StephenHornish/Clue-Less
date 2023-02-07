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
		if Input.is_action_just_pressed("foward"):
			active_player.get_child(0).move_foward()
		if Input.is_action_just_pressed("back"):
			active_player.get_child(0).move_backward()
		if Input.is_action_just_pressed("left") :
			active_player.get_child(0).move_left()
		if Input.is_action_just_pressed("right") :
			active_player.get_child(0).move_right()
		if Input.is_action_just_pressed("ui_accept"):
			active_player.get_child(0).velocity = Vector3.ZERO
			play_turn()
		 
func activateKeyListener() -> void:
	active = true

func _on_Character_Selection_turn_queue(player):
	add_child(player)

