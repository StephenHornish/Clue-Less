extends Node

class_name boardDB

var board : Array
var tile = load("res://Scripts/Tile.gd")
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
	
	board.append(tile.new("TLHall", ["Study","Hall"], ["Left","Right"],true, Vector3( 9.5 ,0, 22.3)))
	board.append(tile.new("TRHall", ["Hall","Lounge"], ["Left","Right"],true, Vector3( -13 ,0, 22.3)))
	board.append(tile.new("MRHall", ["BillardsRoom","DinningRoom"], ["Left","Right"],true, Vector3( -2.3 ,0, -0.5)))
	board.append(tile.new("MLHall", ["Library","BillardsRoom"], ["Left","Right"],true,  Vector3( 9.6,0, -0.01)))
	board.append(tile.new("BLHall", ["Conservatory","BallRoom"], ["Left","Right"],true,  Vector3( 9.3 ,0, -22.3)))
	board.append(tile.new("BRHall", ["BallRoom","Kitchen"], ["Left","Right"],true,  Vector3( -14 ,0, -22.3)))
	board.append(tile.new("BURHall", ["Kitchen","DinningRoom"], ["Up","Down"],true,  Vector3( -25 ,0, -11.2)))
	board.append(tile.new("BUMHall", ["BillardsRoom","BallRoom"], ["Up","Down"],true,   Vector3( -2.4 ,0, -11.8)))
	board.append(tile.new("BULHall", ["Library","Conservatory"], ["Up","Down"],true,    Vector3( 21.3 ,0, -11.8)))
	board.append(tile.new("TDLHall", ["Study","Library"], ["Up","Down"],true,   Vector3( 21.5 ,0, 10.8)))
	board.append(tile.new("TDMHall", ["Hall","BillardsRoom"], ["Up","Down"],true,   Vector3(-2.3,0,10.8)))
	board.append(tile.new("TDRHall", ["Lounge","DinningRoom"], ["Up","Down"],true,   Vector3( -25 ,0, 10.8)))
	
	
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
	
func get_adjacent(tile : Tile) ->Array:
	var tileArray : Array
	for tileName in tile.get_adjacnet():
		tileArray.append(get_room(tileName))
	return tileArray
	
