extends Control

export (NodePath) var dropdown_path_room
export (NodePath) var dropdown_path_weapon
export (NodePath) var dropdown_path_character
onready var dropdownRoom = get_node(dropdown_path_room)
onready var dropdownWeapon = get_node(dropdown_path_weapon)
onready var dropdownCharacter = get_node(dropdown_path_character)
var playerID
var previousSuggestion
var accusationmade : bool

func _ready():
	add_items()

# The rooms should be automatically based on where the player is 
func add_items():
	dropdownRoom.add_item("Ballroom")
	dropdownRoom.add_item("Billiard Room")
	dropdownRoom.add_item("Conservatory")
	dropdownRoom.add_item("Dining Room")
	dropdownRoom.add_item("Hall")
	dropdownRoom.add_item("Kitchen")
	dropdownRoom.add_item("Library")
	dropdownRoom.add_item("Lounge")
	dropdownRoom.add_item("Study")
	dropdownWeapon.add_item("CandleStick")
	dropdownWeapon.add_item("Knife")
	dropdownWeapon.add_item("Pipe")
	dropdownWeapon.add_item("Pistol")
	dropdownWeapon.add_item("Rope")
	dropdownWeapon.add_item("Wrench")
	dropdownCharacter.add_item("Col Mustard")
	dropdownCharacter.add_item("Miss Scarlett")
	dropdownCharacter.add_item("Mr Green")
	dropdownCharacter.add_item("Mrs Peacock")
	dropdownCharacter.add_item("Mrs White")
	dropdownCharacter.add_item("Prof Plumb")


	
func connectButtons():
	var _random_var
	_random_var =$HBoxContainer/SuggestButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_Suggest_button_up")
	_random_var =$HBoxContainer/AccuseButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_Accuse_button_up")
	$HBoxContainer/SuggestButton.disabled = true
	$HBoxContainer/AccuseButton.disabled = true

func update_room(Player : Node) -> void:
	$HBoxContainer.show()
	var tile = Player.get_current_tile()
	$HBoxContainer/AccuseButton.disabled = false
	if(tile.is_Hall()):
		$HBoxContainer/SuggestButton.disabled = true
	else:
		match tile.get_name(): 
			"Ballroom":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(0)
			"Billiard Room":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(1)
			"Conservatory":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(2)
			"Dining Room":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(3)
			"Hall":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(4)
			"Kitchen":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(5)
			"Library":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(6)
			"Lounge":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(7)
			"Study":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(8)
		$HBoxContainer/SuggestButton.disabled = false
