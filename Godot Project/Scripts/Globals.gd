extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var turn = 1
onready var characters : Array
onready var numberOfPlayers = 3
onready var currentTilesArray = [null,null,null,null,null,null]
onready var offSetArray= [ Vector3.ZERO, Vector3(3,0,0),Vector3(-3,0,0),Vector3(3,0,3),Vector3(0,0,3),Vector3(-3,0,3)]
var boardDb = preload("res://Scripts/BoardDB.gd")
var DeckDb = load("res://Scripts/Deck.gd")
var board
var playDeck
# Called when the node enters the scene tree for the first time.
func _ready():
	board = boardDb.new()
	playDeck = DeckDb.new()
	#print(deck)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
