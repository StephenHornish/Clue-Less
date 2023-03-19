extends Control

export (NodePath) var dropdown_path_weapon
export (NodePath) var dropdown_path_character
onready var dropdownWeapon = get_node(dropdown_path_weapon)
onready var dropdownCharacter = get_node(dropdown_path_character)
var playerID

func _ready():
	add_items()

# The rooms should be automatically based on where the player is 
func add_items():
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

func update_room(Player : Node) -> void:
	var tile = Player.get_current_tile()
	if(tile.is_Hall()):
		$HBoxContainer/VBoxContainer/Label.text = "Unable Suggestion"
		$HBoxContainer/SuggestButton.disabled = true
	else:
		$HBoxContainer/VBoxContainer/Label.text = tile.get_name()
		$HBoxContainer/SuggestButton.disabled = false
