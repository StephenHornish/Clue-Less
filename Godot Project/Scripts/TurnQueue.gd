extends Node


class_name TurnQueue

onready var cardDis = load("res://Scenes/CardDisplay.tscn")
var active_player
var active : bool = false
var turnFlag = true
var loserOffset = Vector3(0,0,0)
var numberOfLosers
var currentPlayer
var nextPlayer
var turnOrder
var counter = 1

signal nextTurn
signal addCards
signal updateCards
signal updateMoves
signal disableButtons
signal disableMoveButtons
signal displayLocation
signal placeWeapon(weapon, room)
signal suggestionGather
signal updateClueSheet
signal hideCards


func initialize()-> void:
	active_player = get_node(str(1))
	active_player.set_active()
	activateKeyListener()
	if(get_tree().get_network_unique_id() == 1):
		dealCards()
	buildTurnOrder()
	#emit_signal("updateCards",active_player.get_player_number())
	
func buildTurnOrder():
	var keys_list = Network.players.keys()
	keys_list.sort()
	turnOrder = keys_list
	
		
	# Turnqueue that cycles through all the nodes each time a player makes their turn
# will also emit a singla to the UI lettting everyone know that round is over
func play_turn() -> void:
	print("Player: " + str(active_player.get_player_number()) + "  " + "Character:  " + active_player.get_character_string() )
	active_player.set_inactive()
	turnFlag = true
	print("Active Player: " + str(active_player))
	#if((counter + 1) % Globals.numberOfPlayers == 0):
		#Should say round instead of turn will fix later
		#emit_signal("nextTurn")
	emit_signal("updateMoves",active_player,buildLegalMoveSetButtons(active_player.get_moveset()))
	emit_signal("displayLocation",active_player)
	rpc('nextPlayer')
	active_player= get_node(str(nextPlayer))
	active_player.set_active()
	print("Sharing active Player State with other clients")
	if(active_player.get_tile().get_name() == "LosersBox"):
		play_turn()
	counter +=1

remotesync func nextPlayer():
	var index = turnOrder.find(active_player.name.to_int())
	print("INDEX " + str(index))
	if(index + 1 >= turnOrder.size()):
		nextPlayer = turnOrder[0]
	else:
		nextPlayer = turnOrder[index + 1 ]
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
	for i in range(get_child_count()):
		var child = get_child(i)
		#print("Current Children of Turn Queue: " + child.get_name()) 

func dealCards() -> void:
	#creates the players heads by dealing cards to each client
	buildPlayerHand()
	#creates the players UI
	rpc('buildHandUI')
	#Sends the Hosts deck to the clients 
	sendMasterDeck()

func sendMasterDeck():
	var MasterDeckCardName = []
	var MasterDeckCardType = []
	var SecretDeckCardName = []
	var SecretDeckCardType = []
	for card in Globals.playDeck.deck:
		MasterDeckCardName.append(card.get_name())
		MasterDeckCardType.append(card.get_type())
	for card in Globals.playDeck.secretEnvelop:
		SecretDeckCardName.append(card.get_name())
		SecretDeckCardType.append(card.get_type())
	rpc('buildMasterDeck',MasterDeckCardName,MasterDeckCardType,SecretDeckCardName,SecretDeckCardType)

func buildPlayerHand():
	var cardsPerPlayer = 18/Globals.numberOfPlayers  
	#var leftOver = 18%Globals.numberOfPlayers
	for pair in Network.players:
		var cardName = []
		var cardType = []
		for _y in range(cardsPerPlayer):
			var card = Globals.playDeck.deck[0]
			cardName.append(card.get_name())
			cardType.append(card.get_type())
			Globals.playDeck.deck.remove(0)
		rpc('buildPlayersHand',cardName,cardType,str(pair))
		#where we add the scene to each players view in multiplayer
remotesync func buildHandUI():
	var cardDisplay = cardDis.instance()
	var player = get_node(str(get_tree().get_network_unique_id()))
	cardDisplay.buildPlayerView(player.hand)
	cardDisplay.playerID = get_tree().get_network_unique_id()
	cardDisplay.name = str(get_tree().get_network_unique_id())
	emit_signal("addCards",cardDisplay)

remotesync func buildPlayersHand(MasterHandCardName : Array, MasterHandCardType, _node : String):
	var player = get_node(str(_node))
	player.set_hand(Globals.playDeck.buildHand(MasterHandCardName,MasterHandCardType))
	
remote func buildMasterDeck(MasterDeckCardName : Array, MasterDeckCardType :Array,SecretDeckCardName : Array, SecretDeckCardType: Array ):
	Globals.playDeck.buildDeck(MasterDeckCardName,MasterDeckCardType,SecretDeckCardName,SecretDeckCardType)

#Takes the players moveset and build a new one for all the legal moves around them
#this is done as to not interfer with the keyboard controls for playing hte game
func buildLegalMoveSetButtons(moveSet : Array) -> Array:
	var legalMoveSet = []
	for x in moveSet:
		if(legal_move(x)):
			legalMoveSet.append(x)
	return legalMoveSet
			

func _on_LeftButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		emit_signal("disableMoveButtons",active_player.get_player_number())
		turnFlag = false
		active_player.get_child(0).move_left()
		emit_signal("displayLocation",active_player)


func _on_UpButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		emit_signal("disableMoveButtons",active_player.get_player_number())
		turnFlag = false
		active_player.get_child(0).move_up()
		emit_signal("displayLocation",active_player)


func _on_DownButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		emit_signal("disableMoveButtons",active_player.get_player_number())
		turnFlag = false
		active_player.get_child(0).move_down()
		emit_signal("displayLocation",active_player)


func _on_RightButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		emit_signal("disableMoveButtons",active_player.get_player_number())
		turnFlag = false
		active_player.get_child(0).move_right()
		emit_signal("displayLocation",active_player)


func _on_SecretButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		emit_signal("disableMoveButtons",active_player.get_player_number())
		turnFlag = false
		active_player.get_child(0).move_secret_passage()
		emit_signal("displayLocation",active_player)


func _on_EndTurn_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		active_player.get_child(0).velocity = Vector3.ZERO
		emit_signal("disableButtons",active_player.get_player_number())
		play_turn()


func _on_EnterButton_button_up():
	print("Active Player Name: " + str(active_player.name))
	print("Current ID: " + str(get_tree().get_network_unique_id()))
	if(active_player.name == str(get_tree().get_network_unique_id())):
		active_player.get_child(0).move_up()
		active_player.get_child(0).velocity = Vector3.ZERO
		emit_signal("disableButtons",active_player.get_player_number())
		rpc("_updatePeerMovement", "UP",str(get_tree().get_network_unique_id()))
		play_turn()
		
remote func _updatePeerMovement(_movement, _activeplayer):
	var playerToMove = get_node(_activeplayer)
	match _movement:
		"UP":
			playerToMove.get_child(0).move_up()
			playerToMove.get_child(0).velocity = Vector3.ZERO
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
	print("Gathering Suggestions From other players")
	#emit_signal("suggestionGather",suggestion)
		
		
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


func _on_Timer_timeout():
	print("Timeout")
