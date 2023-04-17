extends MarginContainer

var counterSuggestion 

func _on_TurnQueue_suggestionGather(_weapon,_room,_player):
	print("SUGGEST")
	print(_weapon)
	print(_player)
	print(_room)
	print("SUGGEST")
	get_child(0).requestSuggestion(_weapon,_room,_player)

