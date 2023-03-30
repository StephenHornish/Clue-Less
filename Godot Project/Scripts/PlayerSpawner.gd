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

export(NodePath) onready var timer = get_node(timer) as Timer
export(NodePath) onready var characterSelection = get_node(characterSelection) as Control
var playersReady = 0
onready var number = 0 


func _ready():
	pass

func _on_PeacockButton_button_up():
	#Grabs the scene to add the player to, the button node and sets desired color
	#Replace bob with what ever the multiplayer ID becomes later on
	var player = scene.instance()
	player.build("Bob", player.Players.PEACOCK,Color( 0, 0.501961, 0.501961, 1 ))
	var buttonNode = characterSelection.get_node("MarginContainer1/PeacockButton")

	emit_signal("turn_queue",player)

	#places the character in the starting location and marks the button as clicked 
	player.set_global_translation(Vector3(25,0,-11.5))
	playersReady = playersReady + buttonNode.clicked()
	
	Globals.characters.append("Peacock")
	player.set_tile(Globals.board.get_room("BULHall"))
	rpc("update_button_state", buttonNode)
	player.playerNumber = number 
	number += 1

	


func _on_ScarlettButton_button_up():
	
	var player = scene.instance()
	player.build("Bob", player.Players.SCARLETT,Color( 0.9, 0, 0, 1 ))
	var buttonNode = characterSelection.get_node("MarginContainer2/ScarlettButton")
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-14.5 ,0,26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Scarlett")
	player.set_tile(Globals.board.get_room("TRHall"))
	player.playerNumber = number 
	number += 1

	


func _on_WhiteButton_button_up():
	
	var player = scene.instance()
	player.build("Bob", player.Players.WHITE,Color( 0.980392, 0.921569, 0.843137, 1 ))
	var buttonNode = characterSelection.get_node("MarginContainer3/WhiteButton")
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-14.5 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("White")
	player.set_tile(Globals.board.get_room("BRHall"))
	player.playerNumber = number 
	number += 1




func _on_GreenButton_button_up():
	
	var player = scene.instance()
	player.build("Bob", player.Players.GREEN,Color( 0.133333, 0.545098, 0.133333, 1 ))
	var buttonNode = characterSelection.get_node("MarginContainer4/GreenButton")
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(9 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Green")
	player.set_tile(Globals.board.get_room("BLHall"))
	player.playerNumber = number 
	number += 1
	


func _on_MustardButton_button_up():

	
	var player = scene.instance()
	player.build("Bob", player.Players.MUSTARD,Color( 0.8, 0.9, 0, 1 ) )
	var buttonNode = characterSelection.get_node("MarginContainer5/MustardButton")
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-30 ,0, 11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Mustard")
	player.set_tile(Globals.board.get_room("TDRHall"))
	player.playerNumber = number 
	number += 1

	


func _on_PlumbButton_button_up():

	var player = scene.instance()
	player.build("Bob", player.Players.PLUMB,Color( 0.576471, 0.439216, 0.858824, 1 ) )
	var buttonNode = characterSelection.get_node("MarginContainer6/PlumbButton")
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(25 ,0,11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Plumb")
	player.set_tile(Globals.board.get_room("TDLHall"))
	player.playerNumber = number 
	number += 1



#function for when the ready button is pressed
func _on_Button_button_up() -> void:
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	if(playersReady == Globals.numberOfPlayers):
		_build_player_ui()
		turn.text = "Turn " + str(Globals.turn)
		characterSelection.get_parent().hide()
		emit_signal("initialize_turn_queue")
		emit_signal("randomize_weapons")
		$"CanvasLayer/MarginContainer".hide()
		turn.show()
		timer.start()	
	elif(playersReady > Globals.numberOfPlayers):
		print("Bug more players ready then exist")
		pass
	else:
		turn.text = "Awaiting More players"
		print("Waiting for everyone")

func update_button_visual_appearance():
	print(":HI")

func _on_network_message(id, message):
	print(id)
	print(message)
	if message.get_name() == "update_button_state":
		#button_pressed = message.get_argument(0)
		#update_button_visual_appearance()
		pass
		
#Called on everyone elese machines 
remote func update_button_state(button_node):
	for button in get_tree().get_nodes_in_group("PlayerSelectionButtons"):
		print(button.player.playerNumber)
		print(button_node.player.playerNumber)
		if button.player.playerNumber == button_node.player.playerNumber:
			print(button_node.player.playerNumber)
			button.clicked(playersReady & (1 << button.player.playerNumber) != 0)
			print(playersReady)


func _on_Timer_timeout() -> void:
	turn.hide()
	timer.stop()
	
func incrementTurn() -> void:
	Globals.turn += 1
	turn.text = "Turn " + str(Globals.turn)
	turn.show()
	timer.start()


#Gives Each player a move set Pannel and a suggestion pannel
func _build_player_ui():
	var i = 0
	for _x in range (0,Globals.numberOfPlayers):
		var MoveButtons = MoveBut.instance()
		var SugestionSet = Sugg.instance()
		var GameSheet = gameSheet.instance()
		MoveButtons.playerID = i 
		SugestionSet.playerID = i
		GameSheet.playerID = i
		MoveButtons.character = Globals.characters[i]
		$CanvasLayer/MoveSet.add_child(MoveButtons)
		$CanvasLayer/SuggestionSet.add_child(SugestionSet)
		$CanvasLayer/ClueSheet.add_child(GameSheet)
		MoveButtons.buildMoves([])
		MoveButtons.connectButtons()
		SugestionSet.connectButtons()
		i = i+1

	

#Might be redundant 
func _on_TurnQueue_addCards(cardScene):
	$CanvasLayer/CardDisplay.add_child(cardScene)



