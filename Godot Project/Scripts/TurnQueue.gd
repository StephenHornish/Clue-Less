extends Node


class_name TurnQueue

onready var cardDis = load("res://Scenes/CardDisplay.tscn")
var active_player
var active : bool = false
var turnFlag = true
var loserOffset = Vector3(0,0,0)
var numberOfLosers
var past_player
var nextPlayer
var turnOrder
var counter = 0
var currentSuggestion
var suggestion = []

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
signal currentPlayer
signal endGame
signal suggestionUI
signal activeTimer
signal timerStop
signal toggleEndTurn
signal counterSuggestionUI


func initialize()-> void:
	active_player = get_node(str(1))
	active_player.set_active()
	activateKeyListener()
	if(get_tree().get_network_unique_id() == 1):
		dealCards()
	buildTurnOrder()
	var i = 0 
	for x in turnOrder:
		var player = get_node(str(x))
		player.set_turn_order(i)
		i += 1
	emit_signal("currentPlayer", active_player.name)
	#emit_signal("updateCards",active_player.get_player_number())
	
func buildTurnOrder():
	var keys_list = Network.players.keys()
	keys_list.sort()
	turnOrder = keys_list
	

# Key listener that takes the input Delta is basically each tick fo the game engine
# not required for what we are doing right now. Key Listener becomes active once all
# players have spawned in and selected ready this way players can move pieces early
# when user input is made it checks if thats a legal move. If so it calls on the kin-
# ematic body of the pawn to phycially move it 
func _process(_delta) -> void: 
	if(active):
		if Input.is_action_just_pressed("Up"):
			if(legal_move("Up") && turnFlag):
				rpc("_updatePeerMovement", "Up",str(get_tree().get_network_unique_id()))
				emit_signal('disableMoveButtons')
				emit_signal("displayLocation",active_player)
				turnFlag = false
		if Input.is_action_just_pressed("Down"):
			if(legal_move("Down")&& turnFlag):
				rpc("_updatePeerMovement", "Down",str(get_tree().get_network_unique_id()))
				emit_signal('disableMoveButtons')
				emit_signal("displayLocation",active_player)
				turnFlag = false
		if Input.is_action_just_pressed("Left") :
			if(legal_move("Left")&& turnFlag):
				rpc("_updatePeerMovement", "Left",str(get_tree().get_network_unique_id()))
				emit_signal('disableMoveButtons')
				emit_signal("displayLocation",active_player)
				turnFlag = false
		if Input.is_action_just_pressed("Right") :
			if(legal_move("Right")&& turnFlag):
				rpc("_updatePeerMovement", "Right",str(get_tree().get_network_unique_id()))
				emit_signal('disableMoveButtons')
				emit_signal("displayLocation",active_player)
				turnFlag = false
		if Input.is_action_just_pressed("ui_accept"):
			if(Globals.turn == 1):
				var _nextplayer = nextPlayer(str(get_tree().get_network_unique_id()))
				emit_signal("disableButtons")
				emit_signal("updateMoves",active_player,buildLegalMoveSetButtons(active_player.get_moveset()))
				rpc("_updatePeerMovement", "Up",str(get_tree().get_network_unique_id()))
				rpc("_updateCurrentPlayer",str(get_tree().get_network_unique_id()),nextPlayer)
				rpc('_clearSuggestion')
			else: 
				emit_signal("disableButtons")
				rpc("_updateCurrentPlayer",str(get_tree().get_network_unique_id()),nextPlayer)
		if Input.is_action_just_pressed("Secret Passage") :
			if(legal_move("Secret Passage")&& turnFlag):
				rpc("_updatePeerMovement", "Secret Passage",str(get_tree().get_network_unique_id()))
				emit_signal('disableMoveButtons')
				emit_signal("displayLocation",active_player)
				turnFlag = false
		 
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
		rpc("_updatePeerMovement", "Left",str(get_tree().get_network_unique_id()))
		emit_signal('disableMoveButtons')
		emit_signal("displayLocation",active_player)
		turnFlag = false
		


func _on_UpButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		rpc("_updatePeerMovement", "Up",str(get_tree().get_network_unique_id()))
		emit_signal('disableMoveButtons')
		emit_signal("displayLocation",active_player)
		turnFlag = false


func _on_DownButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		rpc("_updatePeerMovement", "Down",str(get_tree().get_network_unique_id()))
		emit_signal('disableMoveButtons')
		emit_signal("displayLocation",active_player)
		turnFlag = false


func _on_RightButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		rpc("_updatePeerMovement", "Right",str(get_tree().get_network_unique_id()))
		emit_signal('disableMoveButtons')
		emit_signal("displayLocation",active_player)
		turnFlag = false


func _on_SecretButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		rpc("_updatePeerMovement", "Secret Passage",str(get_tree().get_network_unique_id()))
		emit_signal('disableMoveButtons')
		emit_signal("displayLocation",active_player)
		turnFlag = false


func _on_EndTurn_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		print(Globals.playDeck.secretEnvelop)
		emit_signal("disableButtons")
		print(suggestion)
		rpc("_updateCurrentPlayer",str(get_tree().get_network_unique_id()),nextPlayer)
		rpc('_clearSuggestion')


func _on_EnterButton_button_up():
	if(active_player.name == str(get_tree().get_network_unique_id())):
		var _nextplayer = nextPlayer(str(get_tree().get_network_unique_id()))
		emit_signal("disableButtons")
		emit_signal("updateMoves",active_player,buildLegalMoveSetButtons(active_player.get_moveset()))
		rpc("_updatePeerMovement", "Up",str(get_tree().get_network_unique_id()))
		rpc("_updateCurrentPlayer",str(get_tree().get_network_unique_id()),nextPlayer)

remotesync func _updateCurrentPlayer(_activeplayer,_nextPlayer):
	var playerToMove = get_node(_activeplayer)
	past_player = playerToMove 
	active_player = get_node(str(_nextPlayer))
	emit_signal("currentPlayer", active_player.name)
	if(past_player.get_turn_order() == turnOrder.size() - 1):
		emit_signal("nextTurn")
	if(active_player.name == str(get_tree().get_network_unique_id()) && Globals.turn > 1):
		emit_signal("updateMoves",active_player,buildLegalMoveSetButtons(active_player.get_moveset()))
		active = true
		turnFlag = true
	else: 
		turnFlag = true
		active = false
		

remotesync func _updatePeerMovement(_movement, _activeplayer):
	var playerToMove = get_node(_activeplayer)
	match _movement:
		"Up":
			playerToMove.get_child(0).move_up()
		"Left":
			playerToMove.get_child(0).move_left()
		"Right":
			playerToMove.get_child(0).move_right()
		"Down":
			playerToMove.get_child(0).move_down()
		"Secret Passage":
			playerToMove.get_child(0).move_secret_passage()
			


func nextPlayer(_player)->String:
	var index = turnOrder.find(_player.to_int())
	if(index + 1 >= turnOrder.size()):
		nextPlayer = turnOrder[0]
	else:
		nextPlayer = turnOrder[index + 1 ]
	return nextPlayer
#Move the player that was suggested into the room and also the weapon then begin the suggestion check
func _on_Suggest_button_up(_suggestion):
	print(Globals.playDeck.secretEnvelop)
	var room = _suggestion[0]
	var weapon = _suggestion[1]
	var player = _suggestion[2]
	print("Gathering Suggestions From other players")
	rpc('_movePlayerToRoom',player,room)
	rpc('_placeWeapon',weapon,room)
	rpc('_makeSuggestionUI',active_player.name, str(weapon),str(room),str(player))
	rpc('_gatherSuggestion',str(weapon),str(room),str(player))
	emit_signal("toggleEndTurn",true)
	emit_signal("activeTimer")
	#emit_signal("suggestionGather",suggestion)
		
		
		#give each player the scene control disable their end turn button and moves 
		#Put a time limit on the player to pick 
		#emit signal from the cardDisplay back to the turnqueue with the valid suggestion cards
func _on_ServerTimer_timeout():
	emit_signal('timerStop')
	emit_signal("toggleEndTurn",false)
	emit_signal("counterSuggestionUI",suggestion)
	
	
#Check and see if the selected items match the secret envolope
#If correct winner
#If incorrect remove players piece from teh board player now is only there to disprove suggestions
func _on_Accuse_button_up(accusation):
	print("ACCUSE BUTTON")
	print(accusation)
	print(Globals.playDeck.secretEnvelop)
	if(Globals.playDeck.checkWinner(accusation)):
		print("Winner!")
		rpc("_endgame")
	else:
		rpc('_loser')
		if(Globals.numberOfPlayers == numberOfLosers):
			_endgame()
			
remotesync func _loser():
		print("LOSER!")
		active_player.set_tile(Globals.board.get_room("LosersBox"))
		active_player.get_child(0).set_global_translation(active_player.get_location() + loserOffset)
		loserOffset = loserOffset + Vector3(0,0,4)
	

remotesync func _movePlayerToRoom(player,room):
	for child in get_children():
		print(player)
		print(room)
		print(child.get_character_string())
		if(child.get_character_string() == player):
			child.get_child(0).move_room_suggestion(Globals.board.get_room(room))



remotesync func _clearSuggestion():
	suggestion = []

remotesync func _placeWeapon(_weapon, _room):
	emit_signal("placeWeapon",_weapon,_room)
	
remote func _makeSuggestionUI(_playID,_weapon,_room,_player):
	emit_signal('suggestionUI',_playID, _weapon,_room,_player)

remote func _gatherSuggestion(_weapon,_room,_player):
	print("RUNS")
	emit_signal("suggestionGather",_weapon,_room,_player)

remotesync func _endgame():
	Globals.gameOver = true
	emit_signal("endGame",active_player.name)
	

func _on_CardDisplay_sendSuggestion(counterSuggestion):
	currentSuggestion = counterSuggestion
	suggestion.append(counterSuggestion)
	rpc('_send_info',counterSuggestion)

remote func _send_info(counterSuggestion):
	suggestion.append(counterSuggestion)
