extends Node


class_name TurnQueue

onready var cardDis = load("res://Scenes/CardDisplay.tscn")
var active_player
var active : bool = false

signal nextTurn
signal addCards
signal updateCards
signal addMoves
signal updateMoves
signal releaseMoves


func initialize()-> void:
	active_player = get_child(0)
	active_player.set_active()
	activateKeyListener()
	dealCards()
	emit_signal("updateCards",active_player.get_player_number())

# Turnqueue that cycles through all the nodes each time a player makes their turn
# will also emit a singla to the UI lettting everyone know that round is over
func play_turn() -> Node:
	active_player.set_inactive()
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	if((active_player.get_index() + 1) % Globals.numberOfPlayers == 0):
		#Should say round instead of turn will fix later
		emit_signal("nextTurn")
	active_player = get_child(new_player)
	emit_signal("updateCards",active_player.get_player_number())
	emit_signal("updateMoves",active_player)
	
	print(active_player.get_character_string())
	active_player.set_active()
	return active_player
	

# Key listener that takes the input Delta is basically each tick fo the game engine
# not required for what we are doing right now. Key Listener becomes active once all
# players have spawned in and selected ready this way players can move pieces early
# when user input is made it checks if thats a legal move. If so it calls on the kin-
# ematic body of the pawn to phycially move it 
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
		if Input.is_action_just_pressed("Secret Passage") :
			if(legal_move("Secret Passage")):
				active_player.get_child(0).move_secret_passage()
		 
func activateKeyListener() -> void:
	active = true

#Determines if the selected move is indeed legal
func legal_move(movement : String)->bool:
	var currtile = active_player.get_tile()
	#First move is always legal and so are secret passage moves
	if(Globals.turn == 1 || (movement == "Secret Passage" && currtile.get_moveset().has("Secret Passage"))):
		return true
	#Checks to see if the current palyer tile has the move inputed by the player if 
	#so it goes through all children to see if they are in that tile if they are and 
	# that tile is a hall it returns a false because it is not legal to enter hall with 
	#another player
	if(currtile.get_moveset().has(movement)):
		var pos = currtile.get_moveset().find(movement)
		var adjNodeList = currtile.get_adjacenet()
		var nextTile = adjNodeList[pos]
		for child in self.get_children():
			if(child.get_tile() == nextTile && child.get_tile().is_Hall()):
				return false
		return true
	else:
		return false


func _on_Character_Selection_turn_queue(player):
	add_child(player)

func dealCards() -> void:
	var cardsPerPlayer = 18/Globals.numberOfPlayers  
	#var leftOver = 18%Globals.numberOfPlayers 
	
	for x in range(Globals.numberOfPlayers):
		var hand = []
		for y in range(cardsPerPlayer):
			var card = Globals.playDeck.deck[0]
			hand.append(card)
			Globals.playDeck.deck.remove(0)
		var player = get_child(x)
		player.set_hand(hand)
		
		#where we add the scene to each players view in multiplayer
		var cardDisplay = cardDis.instance()
		cardDisplay.buildPlayerView(hand)
		#later should be changed to the player ID when multiplayer is implemented
		cardDisplay.playerID = player.get_player_number()
		emit_signal("addCards",cardDisplay)
		
		
	for x in range(Globals.numberOfPlayers):
		var player = get_child(x)
		print("Player " + str(x + 1))
		print(player.hand)
	print("Cards That everyone can see")
	print(Globals.playDeck.deck)



func _on_TurnQueue_updateMoves():
	pass # Replace with function body.
