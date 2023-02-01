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
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BallRoom_body_entered(body):
	active_player.set_location("BallRoom")
