extends Node


class_name TurnQueue

var active_player

func initialize():
	active_player = get_child(0)
	
func play_turn():
	yield(active_player.play_turn(),"completed")
	active_player.set_inactive()
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	active_player = get_child(new_player)
	print(active_player.playID)
	active_player.set_active()
	
