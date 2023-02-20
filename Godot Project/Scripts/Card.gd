extends Node


class_name Card

enum CardType{
	CHARACTER,
	ROOM, 
	WEAPON
}

var cardname: String
var type

func _init(_name: String, _type):
	self.cardname = _name
	self.type = _type
	
func _to_string()->String:
	return str(cardname) + "|" + str(type)

func get_type():
	return type
