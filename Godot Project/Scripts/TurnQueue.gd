extends Node


class_name TurnQueue

var active_player
var active : bool = false
signal nextTurn


func initialize()-> void:
	active_player = get_child(0)
	active_player.set_active()
	activateKeyListener()
	
func play_turn() -> Node:
	active_player.set_inactive()
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	if((active_player.get_index() + 1) % Globals.numberOfPlayers == 0):
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

func _on_BallRoom_body_entered(body):
	print(body)
	active_player.set_location("BallRoom")
	print(active_player.get_adjacent())


func _on_Hall_body_entered(body):
	print(body)
	active_player.set_location("Hall")
	print(active_player.get_adjacent())


func _on_BRHall_body_entered(body):
	print(body)
	active_player.set_location("BRHall")
	print(active_player.get_adjacent())


func _on_Conservatory_body_entered(body):
	print(body)
	active_player.set_location("Conservatory")
	print(active_player.get_adjacent())


func _on_Library_body_entered(body):
	print(body)
	active_player.set_location("Library")
	print(active_player.get_adjacent())


func _on_Study_body_entered(body):
	print(body)
	active_player.set_location("Study")
	print(active_player.get_adjacent())


func _on_Lounge_body_entered(body):
	print(body)
	active_player.set_location("Lounge")
	print(active_player.get_adjacent())


func _on_DinningRoom_body_entered(body):
	print(body)
	active_player.set_location("DinningRoom")
	print(active_player.get_adjacent())


func _on_Kitchen_body_entered(body):
	print(body)
	active_player.set_location("Kitchen")
	print(active_player.get_adjacent())


func _on_BilliardsRoom_body_entered(body):
	print(body)
	active_player.set_location("BilliardsRoom")
	print(active_player.get_adjacent())


func _on_TLHall_body_entered(body):
	print(body)
	active_player.set_location("TLHall")
	print(active_player.get_adjacent())


func _on_TRHall_body_entered(body):
	print(body)
	active_player.set_location("TRHall")
	print(active_player.get_adjacent())


func _on_MRHall_body_entered(body):
	print(body)
	active_player.set_location("MRHall")
	print(active_player.get_adjacent())


func _on_MLHall_body_entered(body):
	print(body)
	active_player.set_location("MLHall")
	print(active_player.get_adjacent())


func _on_BLHall_body_entered(body):
	print(body)
	active_player.set_location("BLHall")
	print(active_player.get_adjacent())


func _on_BURHall_body_entered(body):
	print(body)
	active_player.set_location("BURHall")
	print(active_player.get_adjacent())


func _on_BUMHall_body_entered(body):
	print(body)
	active_player.set_location("BUMHall")
	print(active_player.get_adjacent())


func _on_BULHall_body_entered(body):
	print(body)
	active_player.set_location("BULHall")
	print(active_player.get_adjacent())


func _on_TDLHall_body_entered(body):
	print(body)
	active_player.set_location("TDLHall")
	print(active_player.get_adjacent())


func _on_TDMHall_body_entered(body):
	print(body)
	active_player.set_location("TDMHall")
	print(active_player.get_adjacent())


func _on_TDRHall_body_entered(body):
	print(body)
	active_player.set_location("TDRHall")
	print(active_player.get_adjacent())



