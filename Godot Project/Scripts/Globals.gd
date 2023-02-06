extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn = 1
onready var characters : Array
onready var numberOfPlayers = 4
var boardDb = preload("res://Scripts/RoomData.gd")
var board
# Called when the node enters the scene tree for the first time.
func _ready():
	board = boardDb.new()
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

