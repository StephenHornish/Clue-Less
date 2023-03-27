extends MarginContainer

var counterSuggestion = []
var suggestions = []

func _on_TurnQueue_updateCards(current_playerID):
	for player_hand in get_children():
		var player_id = player_hand.playerID
		if current_playerID == player_id: 
			player_hand.show()
		else: 
			player_hand.hide()



func _on_TurnQueue_suggestionGather(_suggestion):
	var suggestioncounter = 0 
	suggestions = _suggestion
	for child in get_children():
		child.requestSuggestion(suggestions)
		while not child.suggestionMade:
			yield(get_tree().create_timer(0.1), "timeout")
		if(_valid_suggestion(child.cardclicked) == false):
			child.requestSuggestion(suggestions)
			counterSuggestion.append(child.cardclicked)
		print(counterSuggestion)
	


	
func _valid_suggestion(suggest):
	return suggestions.has(suggest)
