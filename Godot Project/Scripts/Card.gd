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
	var temp
	match type:
		CardType.CHARACTER:
			temp = "Character Card"
		CardType.ROOM:
			temp =  "Room Card"
		CardType.WEAPON:
			temp = "Weapon Card"
	return str(cardname) + "|" +  temp

func get_type():
	return type
