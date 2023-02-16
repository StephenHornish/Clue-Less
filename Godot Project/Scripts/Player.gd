extends Node

class_name Player


enum Players {
	PEACOCK,
	PLUMB,
	WHITE,
	MUSTARD,
	GREEN,
	SCARLETT
}

enum Weapons {
	ROPE,
	KNIFE,
	CANDLESTICK,
	PIPE,
	REVOLVER,
	WRENCH
}

var playerID
var character
var weapon 
var tiles = []

func _init(_playerID,_character):
	playerID = _playerID
	character = _character

func set_weapon(_weapon):
	 weapon = _weapon

func get_weapon():
	return weapon

func get_characterTest():
	return Players.PEACOCK

func get_character():
	return character
