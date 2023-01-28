extends Node

# Need to set the starting locations based on which players are actually 
# playing 
func _ready():
	var scene = load("res://Characters/Pawn.tscn")
	var player = scene.instance()
	add_child(player)

