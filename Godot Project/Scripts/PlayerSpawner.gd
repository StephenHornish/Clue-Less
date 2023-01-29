extends Node

# Need to set the starting locations based on which players are actually 
# playing 

var scene = load("res://Characters/Pawn.tscn")
func _ready():
	pass

#Plan on next placing eacch peace in the correct starting location 
#Remove player options as they are selected then readd them if they pick another piece
#Figure out a ready system 

func _on_PeacockButton_button_up():
	var player = scene.instance()
	var color = Color( 0, 0.501961, 0.501961, 1 )
	player.set_color(color)
	var p = player.get_global_transform()
	player.set_global_translation(Vector3(5,0,10))
	add_child(player)
	#hides the selected 
	$"CanvasLayer/CharacterBox".hide()
	var menu = get_node("CanvasLayer/CharacterBox")
	menu.queue_free()

	pass # Replace with function body.


func _on_ScarlettButton_button_up():
	var player = scene.instance()
	var color = Color( 0.9, 0, 0, 1 )  
	player.set_color(color)
	add_child(player)
	var menu = get_node("Scene Control/Character Selection")
	menu.queue_free()
	pass # R	pass # Replace with function body.


func _on_WhiteButton_button_up():
	var player = scene.instance()
	var color = Color( 0.980392, 0.921569, 0.843137, 1 ) 
	player.set_color(color)
	add_child(player)
	var menu = get_node("Scene Control/Character Selection")
	menu.queue_free()
	pass # Replace with function body.


func _on_GreenButton_button_up():
	var player = scene.instance()
	var color =  Color( 0.133333, 0.545098, 0.133333, 1 )
	player.set_color(color)
	add_child(player)
	var menu = get_node("Scene Control/Character Selection")
	menu.queue_free()
	pass # Rpass # Replace with function body.


func _on_MustardButton_button_up():
	var player = scene.instance()
	var color = Color( 0.8, 0.9, 0, 1 ) 
	player.set_color(color)
	add_child(player)
	var menu = get_node("Scene Control/Character Selection")
	menu.queue_free()
	pass # Rpass # Replace with function body.


func _on_PlumbButton_button_up():
	var player = scene.instance()
	var color = Color( 0.576471, 0.439216, 0.858824, 1 )
	player.set_color(color)
	add_child(player)
	var menu = get_node("Scene Control/Character Selection")
	menu.queue_free()
	pass # Rpass # Replace with function body.
