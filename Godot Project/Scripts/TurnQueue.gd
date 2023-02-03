extends Node


class_name TurnQueue

var active_player
var active : bool = false


func initialize():
	active_player = get_child(0)
	active_player.set_active()
	
func play_turn():
	active_player.set_inactive()
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	active_player = get_child(new_player)
	print(active_player.playID)
	active_player.set_active()
	return active_player
	


func _process(delta): 
	if(active):
		if Input.is_action_just_pressed("foward"):
			active_player.get_child(0).move_foward()
		if Input.is_action_just_pressed("back"):
			active_player.get_child(0).move_backward()
		if Input.is_action_just_pressed("left") :
			active_player.get_child(0).move_left()
		if Input.is_action_just_pressed("right") :
			active_player.get_child(0).move_right()
		
		 
func activateKeyListener():
	active = true
	
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
