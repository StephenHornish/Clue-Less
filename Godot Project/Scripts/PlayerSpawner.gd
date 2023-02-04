extends Node

# Need to set the starting locations based on which players are actually 
# playing 

var scene = load("res://Characters/Pawn.tscn")
onready var turn = get_node("CanvasLayer/Turn Margin Container/Turn").hide()
onready var turnQueue = get_parent().get_parent().get_child(0)
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
	turnQueue.add_child(player)

	#places the character in the starting location and marks the button as clicked 
	player.set_global_translation(Vector3(25,0,-11.5))
	playersReady = playersReady + buttonNode.clicked()
	
	Globals.characters.append("Peacock")
	player.set_playerID("Peacock")
	


func _on_ScarlettButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer2/ScarlettButton")
	var color = Color( 0.9, 0, 0, 1 )  
	player.set_color(color)
	turnQueue.add_child(player)
	player.set_global_translation(Vector3(-14.5 ,0,26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Scarlett")
	player.set_playerID("Scarlett")
	


func _on_WhiteButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer3/WhiteButton")
	var color = Color( 0.980392, 0.921569, 0.843137, 1 ) 
	player.set_color(color)
	turnQueue.add_child(player)
	player.set_global_translation(Vector3(-14.5 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("White")
	player.set_playerID("White")



func _on_GreenButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer4/GreenButton")
	var color =  Color( 0.133333, 0.545098, 0.133333, 1 )
	player.set_color(color)
	turnQueue.add_child(player)
	player.set_global_translation(Vector3(9 ,0, -26))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Green")
	player.set_playerID("Green")
	


func _on_MustardButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer5/MustardButton")
	var color = Color( 0.8, 0.9, 0, 1 ) 
	player.set_color(color)
	turnQueue.add_child(player)
	player.set_global_translation(Vector3(-30 ,0, 11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Mustard")
	player.set_playerID("Mustard")


func _on_PlumbButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer6/PlumbButton")
	var color = Color( 0.576471, 0.439216, 0.858824, 1 )
	player.set_color(color)
	turnQueue.add_child(player)
	player.set_global_translation(Vector3(25 ,0,11.5))
	playersReady = playersReady + buttonNode.clicked()
	Globals.characters.append("Plumb")
	player.set_playerID("Plumb")


#function for when the ready button is pressed
func _on_Button_button_up():
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	if(playersReady == Globals.numberOfPlayers):
		turn.text = "Turn " + str(Globals.turn)
		vbox.get_parent().hide()
		turnQueue.initialize()
		$"CanvasLayer/MarginContainer".hide()
		turnQueue.activateKeyListener()
		turn.show()
		timer.start()	
	elif(playersReady > Globals.numberOfPlayers):
		print("Bug more players ready then exist")
		pass
	else:
		turn.text = "Awaiting More players"
		print("Waiting for everyone")


func _on_Timer_timeout():
	turn = get_node("CanvasLayer/Turn Margin Container/Turn")
	turn.hide()
	timer.stop()
	
