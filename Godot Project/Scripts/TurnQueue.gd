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
			active_player = get_node("../TurnQueue").play_turn()
		
		 
func activateKeyListener():
	active = true
	



func _on_BallRoom_body_entered(body):
	active_player.set_location("BallRoom")
	print(active_player.get_adjacent())
	print("Entered Ball Room")


func _on_Hall_body_entered(body):
	active_player.set_location("Hall")
	print("Entered Hall")
	pass # Replace with function body.


func _on_BRHall_body_entered(body):
	print(body)
	active_player.set_location("BRHall")
	print(active_player.get_adjacent())
	active_player.transform.origin.x = -3.4
	active_player.transform.origin.y = 7.34
	print("BRHall")
	pass # Replace with function body.
