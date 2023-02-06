extends Reference

class_name Tile

var name: String
var adjacent:  Array
var moveset: Array
var isHall: bool
var location: Vector3

func _init(_name:String, _adjacent:Array, _moveSet:Array, _isHall: bool, _location: Vector3):
	name = _name
	adjacent = _adjacent
	moveset	= _moveSet
	isHall = _isHall
	location = _location
	


func _to_string():
	return name

func get_name()->String:
	return name

func get_moveset()-> Array:
	return moveset
	
func get_adjacnet()-> Array:
	return adjacent 
	
	
func is_Hall()-> bool:
	return isHall

func get_location()-> Vector3:
	return location
