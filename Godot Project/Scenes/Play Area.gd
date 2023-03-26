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
	place_weapon(3,"CandleStick")
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


func _on_TurnQueue_placeWeapon(_weapon, _room):
	#Update the tile 
	var temp_tile = Globals.board.get_room(_room)
	temp_tile.set_weapon(_weapon)
	#get a reference to the weapon node so it can be moved on the UI
	var weaponNode = _get_weapon_child(_weapon)
	var location 
	if(_room == "Conservatory"):
		location = Vector3(21.4,0.5,-28.8)
	if(_room == "BallRoom"):
		location = Vector3(-1.8,0.5,-28.8)
	if(_room == "Kitchen"):
		location = Vector3(-26,0.5,-28.8)
	if(_room == "DinningRoom"):
		location = Vector3(-26,0.5,-5.9)
	if(_room == "BillardsRoom"):
		location = Vector3(-2.1,0.5,-5.9)
	if(_room == "Library"):
		location = Vector3(21.4,0.5,-5.9)
	if(_room == "Study"):
		location = Vector3(22,0.5,16.7)
	if(_room == "Hall"):
		location = Vector3(-2.2,0.5,16.7)
	if(_room == "Lounge"):
		location = Vector3(-25,0.5,16.7)
	weaponNode.set_global_translation(location)
	
	
func _get_weapon_child(_weapon) -> Node:
	var weaponRef
	if(_weapon == "Knife"):
		weaponRef = board.get_child(0)
	if(_weapon == "Pipe"):
		weaponRef = board.get_child(1)
	if(_weapon == "Pistol"):
		weaponRef = board.get_child(2)
	if(_weapon == "CandleStick"):
		weaponRef = board.get_child(3)
	if(_weapon == "Wrench"):
		weaponRef = board.get_child(4)
	if(_weapon == "Rope"):
		weaponRef = board.get_child(5)
	return weaponRef
