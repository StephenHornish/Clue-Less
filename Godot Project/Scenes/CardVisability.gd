extends MarginContainer

var counterSuggestion = ''
signal sendSuggestion

func _on_TurnQueue_suggestionGather(_weapon,_room,_player):
	counterSuggestion = ''
	print("SUGGEST")
	print(_weapon)
	print(_player)
	print(_room)
	print("SUGGEST")
	get_child(2).requestSuggestion(_weapon,_room,_player)
	var timer = get_node("ClientTimer")
	timer.start()



func _on_ClientTimer_timeout():
	emit_signal('sendSuggestion',counterSuggestion)
	var timer = get_node("ClientTimer")
	print("Timer Ran Client")
	timer.stop()
	


func _on_TurnQueue_activeTimer():
	var timer = get_node("ServerTimer")
	timer.start()


func _on_TurnQueue_timerStop():
	var timer = get_node("ServerTimer")
	timer.stop()

