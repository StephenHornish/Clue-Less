extends StaticBody

onready var weapons_location = [ Vector3(21.4,0.5,-28.8), Vector3(-1.8,0.5,-28.8), Vector3(-26,0.5,-28.8),Vector3(-26,0.5,-5.9),Vector3(-2.1,0.5,-5.9),Vector3(21.4,0.5,-5.9),Vector3(22,0.5,16.7),Vector3(-2.2,0.5,16.7),Vector3(-25,0.5,16.7)]
onready var board = get_child(0)

func _ready():
	randomize() 
	weapons_location.shuffle()

func _on_Character_Selection_randomize_weapons():
	
	board.get_child(0).set_global_translation( weapons_location[0])
	place_weapon(0,"Knife")
	board.get_child(1).set_global_translation( weapons_location[1])
	place_weapon(1,"Pipe")
	board.get_child(2).set_global_translation( weapons_location[2])
	place_weapon(2,"Pistol")
	board.get_child(3).set_global_translation( weapons_location[3])
	place_weapon(3,"Candle Stick")
	board.get_child(4).set_global_translation( weapons_location[4])
	place_weapon(4,"Wrench")
	board.get_child(5).set_global_translation( weapons_location[5])
	place_weapon(5,"Rope")


func place_weapon(i : int, _weapon : String):
	var temp_tile
	if(weapons_location[i] == Vector3(21.4,0.5,-28.8)):
		temp_tile = Globals.board.get_room("Conservatory")
	if(weapons_location[i] ==  Vector3(-1.8,0.5,-28.8)):
		temp_tile = Globals.board.get_room("BallRoom")
	if(weapons_location[i] == Vector3(-26,0.5,-28.8)):
		temp_tile = Globals.board.get_room("Kitchen")
	if(weapons_location[i] == Vector3(-26,0.5,-5.9)):
		temp_tile = Globals.board.get_room("DinningRoom")
	if(weapons_location[i] ==  Vector3(-2.1,0.5,-5.9)):
		temp_tile = Globals.board.get_room("BillardsRoom")
	if(weapons_location[i] == Vector3(21.4,0.5,-5.9)):
		temp_tile = Globals.board.get_room("Library")
	if(weapons_location[i] == Vector3(22,0.5,16.7)):
		temp_tile = Globals.board.get_room("Study")
	if(weapons_location[i] == Vector3(-2.2,0.5,16.7)):
		temp_tile = Globals.board.get_room("Hall")
	if(weapons_location[i] == Vector3(-25,0.5,16.7)):
		temp_tile = Globals.board.get_room("Lounge")
	
	temp_tile.set_weapon(_weapon)
