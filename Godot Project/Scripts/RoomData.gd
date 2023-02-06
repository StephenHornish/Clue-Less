extends Node

class_name boardDB

var board : Array
var tile = preload("res://Scripts/Room.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _init():
	board.append(tile.new("BallRoom", ["BLHAll","BUMHall","BRHall"], ["Left","Up","Right"],false,Vector3( -2.3 ,0, -22.5)))
	board.append(tile.new("Conservatory", ["BLHAll","BULHall","Lounge"], ["Up","Right", "Secret Passage"],false,Vector3( 22 ,0, -22.5)))
	board.append(tile.new("Library", ["MLHAll","BULHall","TDLHall"], ["Up","Right", "Down"],false,Vector3( 22 ,0, -0.5)))
	board.append(tile.new("Study", ["TDLHall","TLHall","Kitchen"], ["Down","Right", "Secret Passage"],false,Vector3( 22 ,0, 22.3)))
	board.append(tile.new("Hall", ["TLHall", "TDMHall","TRHall"], ["Left", "Down","Right"],false,Vector3( -2.3 ,0, 22.3)))
	board.append(tile.new("Lounge", ["TLHall", "MRHall","Conservatory"], ["Left", "Down","Secret Passage"],false, Vector3( -26 ,0 , 21.6)))
	board.append(tile.new("DinningRoom", ["TDRHall", "MRHall","BURHall"], ["Up", "Left","Down"],false, Vector3( -26 ,0, -0.5)))
	board.append(tile.new("Kitchen", ["BURHall", "BRHall","Study"], ["Up", "Left","Secret Passage"],false, Vector3( -26 ,0, -22.5)))
	board.append(tile.new("BillardsRoom", ["MLHall", "TDMHall","MRHall","BUMHall"], ["Left", "Up", "Right","Down"],false, Vector3( -2.3 ,0, -0.5)))
	
	
	
	
func get_room(room : String)->Tile:
	for tile in board:
		if(tile.get_name() == room):
			return tile
	print("not found")
	return null
	

func _to_string()->String:
	var temp = ""
	for tile in board:
		temp = temp + tile.get_name() + ", "
	return temp
