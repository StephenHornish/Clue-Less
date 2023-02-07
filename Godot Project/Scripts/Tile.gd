extends Reference

class_name Tile

var name: String
var adjacent:  Array
var moveset: Array
var isHall: bool
var location: Vector3

func _init(_name:String, _moveSet:Array, _isHall: bool, _location: Vector3):
	name = _name
	moveset	= _moveSet
	isHall = _isHall
	location = _location
	


func _to_string():
	return "Current Tile: " + name +  "     Adjacent Tiles: " 
func get_name()->String:
	return name

func get_moveset()-> Array:
	return moveset
	
func get_adjacenet()-> Array:
	return adjacent 

func set_adjacent(arr : Array) -> Tile:
	adjacent = arr
	return self
	
func is_Hall()-> bool:
	return isHall

func get_location()-> Vector3:
	return location

