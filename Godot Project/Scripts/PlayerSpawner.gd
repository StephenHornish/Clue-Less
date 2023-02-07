extends Node

# Need to set the starting locations based on which players are actually 
# playing 

var scene = load("res://Characters/Pawn.tscn")
onready var turn = get_node("CanvasLayer/Turn Margin Container/Turn").hide() 
signal turn_queue
signal initialize_turn_queue
onready var timer = get_node("CanvasLayer/Turn Margin Container/Turn/Timer")
onready var vbox = get_node("CanvasLayer/CharacterContainer/VBoxContainer/VBoxContainer")
var playersReady = 0


func _ready():
	pass
#Needs to hide menu when all player characters have been selected, Hide button when a character has been selected
#So other players cannot select that character if you swap characters make the button visable again 

func _on_PeacockButton_button_up():
	#Grabs the scene to add the player to, the button node and the creates teh desired color
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer1/PeacockButton")
	var color = Color( 0, 0.501961, 0.501961, 1 )
	#sets player color and adds them to the scene 
	player.set_color(color)
	emit_signal("turn_queue",player)

	#places the character in the starting location and marks the button as clicked 
	player.set_global_translation(Vector3(25,0,-11.5))
	playersReady = playersReady + buttonNode.clicked()
	
	Globals.characters.append("Peacock")
	player.set_playerID("Peacock")
	player.set_tile("BULHall")
	


func _on_ScarlettButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer2/ScarlettButton")
	var color = Color( 0.9, 0, 0, 1 )  
	player.set_color(color)
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-14.5 ,0,26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Scarlett")
	player.set_playerID("Scarlett")
	player.set_tile("TRHall")

	


func _on_WhiteButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer3/WhiteButton")
	var color = Color( 0.980392, 0.921569, 0.843137, 1 ) 
	player.set_color(color)
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-14.5 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("White")
	player.set_playerID("White")
	player.set_tile("BRHall")




func _on_GreenButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer4/GreenButton")
	var color =  Color( 0.133333, 0.545098, 0.133333, 1 )
	player.set_color(color)
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(9 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Green")
	player.set_playerID("Green")
	player.set_tile("BLHall")

	


func _on_MustardButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer5/MustardButton")
	var color = Color( 0.8, 0.9, 0, 1 ) 
	player.set_color(color)
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(-30 ,0, 11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Mustard")
	player.set_playerID("Mustard")
	player.set_tile("TDRHall")

	


func _on_PlumbButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer6/PlumbButton")
	var color = Color( 0.576471, 0.439216, 0.858824, 1 )
	player.set_color(color)
	emit_signal("turn_queue",player)
	player.set_global_translation(Vector3(25 ,0,11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Plumb")
	player.set_playerID("Plumb")
	player.set_tile("TDLHall")



#function for when the ready button is pressed
func _on_Button_button_up() -> void:
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	if(playersReady == Globals.numberOfPlayers):
		turn.text = "Turn " + str(Globals.turn)
		vbox.get_parent().hide()
		emit_signal("initialize_turn_queue")
		$"CanvasLayer/MarginContainer".hide()
		turn.show()
		timer.start()	
	elif(playersReady > Globals.numberOfPlayers):
		print("Bug more players ready then exist")
		pass
	else:
		turn.text = "Awaiting More players"
		print("Waiting for everyone")


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
	
