extends Node

# Need to set the starting locations based on which players are actually 
# playing 

var scene = load("res://Characters/Pawn.tscn")

onready var turn = get_node("CanvasLayer/Turn Margin Container/Turn").hide() 
onready var MoveBut = load("res://Scenes/MoveButtons.tscn")
onready var Sugg = load("res://Scenes/Suggestion.tscn")
onready var gameSheet = load("res://Scenes/Clue_Game_Sheet.tscn")
signal turn_queue
signal initialize_turn_queue
signal randomize_weapons
signal shuffle_deck
var player
var playerNumber = 0

onready var timer = get_node("CanvasLayer/Turn Margin Container/Turn/Timer")
onready var vbox = get_node("CanvasLayer/CharacterContainer/VBoxContainer/VBoxContainer")
onready var turnQueue = get_parent().get_parent().get_child(0)
var playersReady = 0
onready var number = 0 


func _ready():
	get_tree().connect("network_peer_connected",self,"_player_connected")
	get_tree().connect("network_peer_disconnected",self,"_player_disconnected")
	Globals.connect("instance_player",self,"_instance_player")
	if get_tree().network_peer != null:
		Globals.emit_signal("toggle_network_setup",false)
	
	 
func _instance_player(id):
	player = scene.instance()
	player.hide()
	player.set_network_master(id)
	player.name = str(id)
	emit_signal("turn_queue",player)
	if(get_tree().get_network_unique_id() != 1):
		get_node("CanvasLayer/MarginContainer/VBoxContainer/Button").hide()

func _player_connected(id):
	print("Player " + str(id) + " has connected")
	_instance_player(id)
	
func _player_disconnected(id):
	print("Player " + str(id) + " has disconnected")
	if has_node(str(id)):
		get_node(str(id)).queue_free()


	
func _on_PeacockButton_button_up():
	#Grabs the scene to add the player to, the button node and sets desired color
	#Replace bob with what ever the multiplayer ID becomes later on
	#gets the player name and number from the user  that selects peackock
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,0, playernum)
	_on_hide_buttons(0)

func _on_ScarlettButton_button_up():
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,1, playernum)
	_on_hide_buttons(1)
	
func _on_WhiteButton_button_up():	
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,2, playernum)
	_on_hide_buttons(2)

func _on_GreenButton_button_up():
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,3,playernum)
	_on_hide_buttons(3)
	
func _on_MustardButton_button_up():
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,4,playernum)
	_on_hide_buttons(4)

func _on_PlumbButton_button_up():
	#This works do not change
	var playerName = Network.players[get_tree().get_network_unique_id()].name
	var playernum = get_tree().get_network_unique_id()
	rpc("_characterBuilder",playerName,5,playernum)
	_on_hide_buttons(5)


#tShould take in parameter of the players naem they inputed and the set_tile should also be a match statement 
#that relates it to the plaeyrs choice
remotesync func _characterBuilder(PlayerName,characterSelected,nodePath):
	for child in turnQueue.get_children():
		print(child)
	var playerRef = turnQueue.get_node(str(nodePath))
	
	
	#this shoudl be changed to look beter later one once it can be confired that there are no dependencies 
	#between the player class 
	match characterSelected: 
		0:
			playerRef.build(PlayerName,nodePath,characterSelected,Color( 0, 0.501961, 0.501961, 1 ))
			playerRef.set_tile(Globals.board.get_room("BULHall"))
			_spawnPlayer(vbox.get_node("MarginContainer1/PeacockButton"),0)
			playerRef.set_global_translation(Vector3(25,0,-11.5))
		1:
			playerRef.build(PlayerName,nodePath, characterSelected,Color( 0.9, 0, 0, 1 ))
			playerRef.set_tile(Globals.board.get_room("TRHall"))
			print(Network.players)
			_spawnPlayer(vbox.get_node("MarginContainer2/ScarlettButton"),1)
			playerRef.set_global_translation(Vector3(-14.5 ,0,26))
		2: 
			playerRef.build(PlayerName,nodePath, characterSelected,Color( 0.980392, 0.921569, 0.843137, 1 ))
			playerRef.set_tile(Globals.board.get_room("BRHall"))
			_spawnPlayer(vbox.get_node("MarginContainer3/WhiteButton"),2)
			playerRef.set_global_translation(Vector3(-14.5 ,0, -26))
		3: 
			playerRef.build(PlayerName,nodePath, characterSelected,Color( 0.133333, 0.545098, 0.133333, 1 ))
			playerRef.set_tile(Globals.board.get_room("BLHall"))
			_spawnPlayer(vbox.get_node("MarginContainer4/GreenButton"),3)
			playerRef.set_global_translation(Vector3(9 ,0, -26))
		4: 
			playerRef.build(PlayerName,nodePath, characterSelected,Color( 0.8, 0.9, 0, 1 ) )
			playerRef.set_tile(Globals.board.get_room("TDRHall"))
			_spawnPlayer(vbox.get_node("MarginContainer5/MustardButton"),4)
			playerRef.set_global_translation(Vector3(-30 ,0, 11.5))
		5: 
			playerRef.build(PlayerName,nodePath, characterSelected,Color( 0.576471, 0.439216, 0.858824, 1 ))
			playerRef.set_tile(Globals.board.get_room("TDLHall"))
			_spawnPlayer(vbox.get_node("MarginContainer6/PlumbButton"),5)
			playerRef.set_global_translation(Vector3(25 ,0,11.5))
			
	playerRef.show()


func _spawnPlayer(buttonNode,nodelocation)->void:
	#places the character in the starting location and marks the button as clicked 
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append(player.character)
	rpc("update_button_state", nodelocation)

#function for when the ready button is pressed
func _on_Button_button_up() -> void:
	print("Ready Call")
	#rpc("sameDecks", Globals.playDeck.deck,Globals.playDeck.secretEnvelop)
	print("Global Number of Players:" + str(Globals.numberOfPlayers))
	print("Number of Players Ready" + str(playersReady))
	if(playersReady == Globals.numberOfPlayers):
		rpc("_build_player_ui")
		$"CanvasLayer/MarginContainer".hide()
		emit_signal("randomize_weapons")
	elif(playersReady > Globals.numberOfPlayers):
		print("Bug more players ready then exist")
		pass
	else:
		turn = get_node("CanvasLayer/Turn Margin Container/Turn")
		turn.text = str(playersReady) + " out of " + str(Globals.numberOfPlayers) + " are ready"
		turn.show()
		timer.start()	

func _on_hide_buttons(buttonOrder : int)-> void: 
	for i in range(0,6):
		if(i == buttonOrder):
			continue
		else: 
			var buttonToHide = vbox.get_child(i).get_child(0)
			buttonToHide.disabled = true
	

#Called on everyone elese machines 
remotesync func update_button_state(button_node):
	var nodef = get_node("CanvasLayer/CharacterContainer/VBoxContainer/VBoxContainer")
	nodef = nodef.get_child(button_node).get_child(0)
	nodef.disabled = true

func _on_Timer_timeout() -> void:
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	turn.hide()
	timer.stop()
	
func incrementTurn() -> void:
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	Globals.turn += 1
	turn.text = "Turn " + str(Globals.turn)
	turn.show()
	timer.start()


#Gives Each player a move set Pannel and a suggestion pannel
remotesync func _build_player_ui():
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	#iterate though the network Dictonary and assign the correct to name each UI element
	#All scene trees must match across the network 
	var ID = str(get_tree().get_network_unique_id())
	var player = turnQueue.get_node(ID)
	var MoveButtons = MoveBut.instance()
	var SugestionSet = Sugg.instance()
	var GameSheet = gameSheet.instance()
		#This can all be changed to .name later
	MoveButtons.playerID = ID
	MoveButtons.character = player.get_character()
	MoveButtons.setColors()
	SugestionSet.playerID = get_tree().get_network_unique_id()
	GameSheet.playerID = get_tree().get_network_unique_id()
	MoveButtons.name = ID
	SugestionSet.name = ID
	GameSheet.name = ID
	$CanvasLayer/MoveSet.add_child(MoveButtons)
	$CanvasLayer/SuggestionSet.add_child(SugestionSet)
	$CanvasLayer/ClueSheet.add_child(GameSheet)
	$CanvasLayer/CharacterContainer.hide()
	turn.text = "Turn " + str(Globals.turn)
	emit_signal("initialize_turn_queue")
	turn.show()
	timer.start()	
	MoveButtons.connectButtons()
	SugestionSet.connectButtons()
	

	


func _on_TurnQueue_addCards(cardScene):
	$CanvasLayer/CardDisplay.add_child(cardScene)


func _find_joinOrder():
	var counter = 0 
	for key in Network.players.keys():
		if(key == get_tree().get_network_unique_id()):
			return counter
		counter += 1
		
remote func sameDecks(deck:Array,secret:Array):
	Globals.playDeck.deck  =  deck
	Globals.playDeck.secretEnvelop = secret
	print("Rmeote Same Deck call")
	print(deck)


func _on_TurnQueue_hideCards():
	var display = $CanvasLayer/CardDisplay
	print("DISPLAY")
	var cards = display.get_node(str(get_tree().get_network_unique_id()))
	cards.show()
	print(get_tree().get_network_unique_id())
	print(display.get_child(0).playerID)
	print(display.get_child(1).playerID)
	


func _on_TurnQueue_currentPlayer(_playerName):
	var label = get_node("CanvasLayer/CurrentPlayer/Label")
	var _text = "Current Player: " + Network.players.get(_playerName.to_int()).name
	label.text = _text
