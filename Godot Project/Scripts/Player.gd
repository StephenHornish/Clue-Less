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

var playerID
var character
var hand = []

func _init(_playerID,_character):
	playerID = _playerID
	character = _character

func get_characterTest():
	return Players.PEACOCK

func get_character():
	return character
	
func get_character_string():
	match character:
		Players.PEACOCK:
			return "Mrs.Peacock"
		Players.PLUMB:
			return "Professor Plumb"
		Players.WHITE:
			return "Mrs.White"
		Players.MUSTARD:
			return "Col Mustard"
		Players.GREEN:
			return "Mr.Green"
		Players.SCARLETT:
			return "Mrs.Scarlett"
