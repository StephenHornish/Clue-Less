extends Node

# Need to set the starting locations based on which players are actually 
# playing 

var scene = load("res://Characters/Pawn.tscn")
var vbox 

func _ready():
	vbox = get_node("CanvasLayer/CharacterContainer/VBoxContainer/VBoxContainer")
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
	add_child(player)

	#places the character in the starting location and marks the button as clicked 
	player.set_global_translation(Vector3(25,0,-11.5))
	buttonNode.clicked()
	


func _on_ScarlettButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer2/ScarlettButton")
	var color = Color( 0.9, 0, 0, 1 )  
	player.set_color(color)
	add_child(player)
	player.set_global_translation(Vector3(-14.5 ,0,26))
	buttonNode.clicked()


func _on_WhiteButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer3/WhiteButton")
	var color = Color( 0.980392, 0.921569, 0.843137, 1 ) 
	player.set_color(color)
	add_child(player)
	player.set_global_translation(Vector3(-14.5 ,0, -26))
	buttonNode.clicked()



func _on_GreenButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer4/GreenButton")
	var color =  Color( 0.133333, 0.545098, 0.133333, 1 )
	player.set_color(color)
	add_child(player)
	player.set_global_translation(Vector3(9 ,0, -26))
	buttonNode.clicked()
	


func _on_MustardButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer5/MustardButton")
	var color = Color( 0.8, 0.9, 0, 1 ) 
	player.set_color(color)
	add_child(player)
	player.set_global_translation(Vector3(-30 ,0, 11.5))
	buttonNode.clicked()


func _on_PlumbButton_button_up():
	var player = scene.instance()
	var buttonNode = vbox.get_node("MarginContainer6/PlumbButton")
	var color = Color( 0.576471, 0.439216, 0.858824, 1 )
	player.set_color(color)
	add_child(player)
	player.set_global_translation(Vector3(25 ,0,11.5))
	buttonNode.clicked()
