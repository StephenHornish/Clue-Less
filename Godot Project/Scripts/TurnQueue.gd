extends Node


class_name TurnQueue

onready var cardDis = load("res://Scenes/CardDisplay.tscn")
var active_player
var active : bool = false
var turnFlag = true
var loserOffset = Vector3(0,0,0)
var numberOfLosers

signal nextTurn
signal addCards
signal updateCards
signal updateMoves
signal disableButtons
signal disableMoveButtons
signal displayLocation
signal placeWeapon(weapon, room)


func initialize()-> void:
	active_player = get_child(0)
	active_player.set_active()
	activateKeyListener()
	dealCards()
	emit_signal("updateCards",active_player.get_player_number())

# Turnqueue that cycles through all the nodes each time a player makes their turn
# will also emit a singla to the UI lettting everyone know that round is over
func play_turn() -> void:
	active_player.set_inactive()
	turnFlag = true
	var new_player : int = (active_player.get_index() + 1) % get_child_count()
	if((active_player.get_index() + 1) % Globals.numberOfPlayers == 0):
		#Should say round instead of turn will fix later
		emit_signal("nextTurn")
	active_player = get_child(new_player)
	emit_signal("updateCards",active_player.get_player_number())
	emit_signal("updateMoves",active_player,buildLegalMoveSetButtons(active_player.get_moveset()))
	emit_signal("displayLocation",active_player)
	active_player.set_active()
	if(active_player.get_tile().get_name() == "LosersBox"):
		play_turn()



# Key listener that takes the input Delta is basically each tick fo the game engine
# not required for what we are doing right now. Key Listener becomes active once all
# players have spawned in and selected ready this way players can move pieces early
# when user input is made it checks if thats a legal move. If so it calls on the kin-
# ematic body of the pawn to phycially move it 
func _process(_delta) -> void: 
	if(active):
		if Input.is_action_just_pressed("Up"):
			if(legal_move("Up") && turnFlag):
				active_player.get_child(0).move_up()
				turnFlag = false
				emit_signal("disableMoveButtons",active_player.get_player_number())
				emit_signal("displayLocation",active_player)
		if Input.is_action_just_pressed("Down"):
			if(legal_move("Down")&& turnFlag):
				active_player.get_child(0).move_down()
				turnFlag = false
				emit_signal("disableMoveButtons",active_player.get_player_number())
				emit_signal("displayLocation",active_player)
		if Input.is_action_just_pressed("Left") :
			if(legal_move("Left")&& turnFlag):
				active_player.get_child(0).move_left()
				turnFlag = false
				emit_signal("disableMoveButtons",active_player.get_player_number())
				emit_signal("displayLocation",active_player)
		if Input.is_action_just_pressed("Right") :
			if(legal_move("Right")&& turnFlag):
				active_player.get_child(0).move_right()
				turnFlag = false
				emit_signal("disableMoveButtons",active_player.get_player_number())
				emit_signal("displayLocation",active_player)
		if Input.is_action_just_pressed("ui_accept"):
			active_player.get_child(0).velocity = Vector3.ZERO
			emit_signal("disableButtons",active_player.get_player_number())
			turnFlag = true
			play_turn()
		if Input.is_action_just_pressed("Secret Passage") :
			if(legal_move("Secret Passage")&& turnFlag):
				active_player.get_child(0).move_secret_passage()
				turnFlag = false
				emit_signal("disableMoveButtons",active_player.get_player_number())
				emit_signal("displayLocation",active_player)
		 
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
		for _y in range(cardsPerPlayer):
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


#Takes the players moveset and build a new one for all the legal moves around them
#this is done as to not interfer with the keyboard controls for playing hte game
func buildLegalMoveSetButtons(moveSet : Array) -> Array:
	var legalMoveSet = []
	for x in moveSet:
		if(legal_move(x)):
			legalMoveSet.append(x)
	return legalMoveSet
			

func _on_LeftButton_button_up():
	emit_signal("disableMoveButtons",active_player.get_player_number())
	turnFlag = false
	active_player.get_child(0).move_left()
	emit_signal("displayLocation",active_player)


func _on_UpButton_button_up():
	emit_signal("disableMoveButtons",active_player.get_player_number())
	turnFlag = false
	active_player.get_child(0).move_up()
	emit_signal("displayLocation",active_player)


func _on_DownButton_button_up():
	emit_signal("disableMoveButtons",active_player.get_player_number())
	turnFlag = false
	active_player.get_child(0).move_down()
	emit_signal("displayLocation",active_player)


func _on_RightButton_button_up():
	emit_signal("disableMoveButtons",active_player.get_player_number())
	turnFlag = false
	active_player.get_child(0).move_right()
	emit_signal("displayLocation",active_player)


func _on_SecretButton_button_up():
	emit_signal("disableMoveButtons",active_player.get_player_number())
	
	turnFlag = false
	active_player.get_child(0).move_secret_passage()
	emit_signal("displayLocation",active_player)


func _on_EndTurn_button_up():
	active_player.get_child(0).velocity = Vector3.ZERO
	emit_signal("disableButtons",active_player.get_player_number())
	play_turn()


func _on_EnterButton_button_up():
	active_player.get_child(0).move_up()
	active_player.get_child(0).velocity = Vector3.ZERO
	emit_signal("disableButtons",active_player.get_player_number())
	play_turn()

#Move the player that was suggested into the room and also the weapon then begin the suggestion check
func _on_Suggest_button_up(suggestion):
	print(Globals.playDeck.secretEnvelop)
	var room = suggestion[0]
	var weapon = suggestion[1]
	var player = suggestion[2]
	var counterSuggestion = []
	emit_signal("placeWeapon",weapon,room)
	for i in range(self.get_child_count()):
		var playerNode = self.get_child(i)
		if(playerNode.get_character_string() == player):
			playerNode.get_child(0).move_room_suggestion(Globals.board.get_room(room))
	#Iterate through each player each player has to go because it would be unfair
	for i in range(self.get_child_count()):
		var playerNode = self.get_child(i)
		var hand = playerNode.get_hand()
		var validCards = []
		#give each player the scene control disable their end turn button and moves 
		#Put a time limit on the player to pick 
		#emit signal from the cardDisplay back to the turnqueue with the valid suggestion cards


#Check and see if the selected items match the secret envolope
#If correct winner
#If incorrect remove players piece from teh board player now is only there to disprove suggestions
func _on_Accuse_button_up(accusation):
	if(Globals.playDeck.checkWinner(accusation)):
		print("Winner!")
		_endgame()
	else:
		print("LOSER!")
		active_player.set_tile(Globals.board.get_room("LosersBox"))
		active_player.get_child(0).set_global_translation(active_player.get_location() + loserOffset)
		loserOffset = loserOffset + Vector3(0,0,4)
		play_turn()
		if(Globals.numberOfPlayers == numberOfLosers):
			_endgame()
		
	
func _endgame():
	print("Game Over")
