extends Node

class_name boardDB

var board : Array
var players : Array
var tile = load("res://Scripts/Tile.gd")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _init():
	var ballroom = tile.new("BallRoom",  ["Left","Up","Right"],false,Vector3( -2.3 ,0, -22.5))
	var conservatory = tile.new("Conservatory", ["Up","Right", "Secret Passage"],false,Vector3( 22 ,0, -22.5))
	var library = tile.new("Library", ["Up","Right", "Down"],false,Vector3( 22 ,0, -0.5))
	var study = tile.new("Study",  ["Down","Right", "Secret Passage"],false,Vector3( 22 ,0, 22.3))
	var hall = tile.new("Hall",["Left", "Down","Right"],false,Vector3( -2.3 ,0, 22.3))
	var lounge = tile.new("Lounge", ["Left", "Down","Secret Passage"],false, Vector3( -26 ,0 , 21.6))
	var dinningroom = tile.new("DinningRoom", ["Up", "Left","Down"],false, Vector3( -26 ,0, -0.5))
	var kitchen = tile.new("Kitchen",  ["Up", "Left","Secret Passage"],false, Vector3( -26 ,0, -22.5))
	var billardsroom = tile.new("BillardsRoom",  ["Left", "Up", "Right","Down"],false, Vector3( -2.3 ,0, -0.5))
	
	var tlHall = tile.new("TLHall", ["Left","Right"],true, Vector3( 9.5 ,0, 22.3))
	var trHall = tile.new("TRHall", ["Left","Right"],true, Vector3( -13 ,0, 22.3))
	var mrHall = tile.new("MRHall", ["Left","Right"],true, Vector3( -14 ,0, -0.5))
	var mlHall = tile.new("MLHall", ["Left","Right"],true,  Vector3( 9.6,0, -0.01))
	var blHall = tile.new("BLHall", ["Left","Right"],true,  Vector3( 9.3 ,0, -22.3))
	var brHall = tile.new("BRHall", ["Left","Right"],true,  Vector3( -14 ,0, -22.3))
	var burHall = tile.new("BURHall", ["Up","Down"],true,  Vector3( -26 ,0, -11.2))
	var bumHall = tile.new("BUMHall", ["Up","Down"],true,  Vector3( -2.4 ,0, -11.8))
	var bulHall = tile.new("BULHall", ["Up","Down"],true,    Vector3( 21.3 ,0, -11.8))
	var tdlHall = tile.new("TDLHall", ["Up","Down"],true,   Vector3( 21.5 ,0, 10.8))
	var tdmHall = tile.new("TDMHall", ["Up","Down"],true,   Vector3(-2.3,0,10.8))
	var tdrHall = tile.new("TDRHall", ["Up","Down"],true,   Vector3( -26 ,0, 10.8))
	
	#setting the adjacency for each tile
	board.append(ballroom.set_adjacent([blHall,bumHall,brHall]))
	board.append(conservatory.set_adjacent([bulHall,blHall,lounge]))
	board.append(library.set_adjacent([tdlHall,mlHall,bulHall]))
	board.append(study.set_adjacent([tdlHall,tlHall,kitchen]))
	board.append(hall.set_adjacent([tlHall,tdmHall,trHall]))
	board.append(lounge.set_adjacent([trHall,tdrHall,conservatory]))
	board.append(dinningroom.set_adjacent([tdrHall,mrHall,burHall]))
	board.append(kitchen.set_adjacent([burHall,brHall,study]))
	board.append(billardsroom.set_adjacent([mlHall,tdmHall,mrHall,bumHall]))
	
	board.append(tlHall.set_adjacent([study,hall]))
	board.append(trHall.set_adjacent([hall,lounge]))
	board.append(mrHall.set_adjacent([billardsroom,dinningroom]))
	board.append(mlHall.set_adjacent([library, billardsroom]))
	board.append(blHall.set_adjacent([conservatory,ballroom]))
	board.append(brHall.set_adjacent([ballroom,kitchen]))
	board.append(burHall.set_adjacent([dinningroom,kitchen]))
	board.append(bumHall.set_adjacent([billardsroom,ballroom]))
	board.append(bulHall.set_adjacent([library,conservatory]))
	board.append(tdlHall.set_adjacent([study,library]))
	board.append(tdmHall.set_adjacent([hall,billardsroom]))
	board.append(tdrHall.set_adjacent([lounge,dinningroom]))




	
	
func get_room(room : String)->Tile:
	for _tile in board:
		if(_tile.get_name() == room):
			return _tile
	print("not found")
	return null
	

func _to_string()->String:
	var temp = ""
	for til in board:
		temp = temp + til.get_name()
		if(til.is_Hall()):
			return temp + ", "
		else:
			var weapon = til.get_weapon()
			if(weapon == ""):
				weapon = "None"
			temp = temp + ": Weapons -> " + weapon + ", "
	return temp
	

	
