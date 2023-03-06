extends Reference

class_name Tile

var name: String
var adjacent:  Array
var moveset: Array
var isHall: bool
var location: Vector3
var occupants: Array
var weapon = ""
const Empty = "" 

func _init(_name:String, _moveSet:Array, _isHall: bool, _location: Vector3):
	name = _name
	moveset	= _moveSet
	isHall = _isHall
	location = _location
	occupants = [Empty,Empty,Empty,Empty,Empty,Empty]
	


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
	
func get_occupants()->Array:
	return occupants
	
func set_weapon(wep : String) ->void:
	weapon = wep
	
func get_weapon() ->String:
	return weapon

func set_occupant(_name : String) -> void:
	var counter := 0
	for x in occupants:
		if(x == Empty):
			occupants[counter] = _name
			return
		counter += 1

func remove_occupant(_name : String) -> void:
	var counter := 0
	for x in occupants:
		if(x == _name):
			occupants[counter] = Empty
			return
		counter += 1
