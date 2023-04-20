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
const empty = ""
var suggestion = [empty,"CandleStick","Col Mustard"]
var accusation = ["Ballroom","CandleStick","Col Mustard"]
signal suggestionSignal
signal accusationSignal

func _ready():
	$HBoxContainer/SuggestButton.disabled = true
	$HBoxContainer/AccuseButton.disabled = true
	add_items()

# The rooms should be automatically based on where the player is 
func add_items():
	dropdownRoom.add_item("BallRoom")
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
	_random_var = connect("suggestionSignal", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_Suggest_button_up")
	_random_var = connect("accusationSignal", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_Accuse_button_up")
	$HBoxContainer/SuggestButton.disabled = true


func update_room(Player : Node, Players_Turn : bool) -> void:
	$HBoxContainer.show()
	var tile = Player.get_current_tile()
	if(tile.is_Hall()):
		$HBoxContainer/SuggestButton.disabled = true
		suggestion[0] = empty
	else:
		match tile.get_name(): 
			"BallRoom":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(0)
			"Billiard Room":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(1)
			"Conservatory":
				$HBoxContainer/VBoxContainer/DropDownRoom.select(2)
			"DiningRoom":
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
		suggestion[0] = tile.get_name()	
		accusation[0] = tile.get_name()
		if(Players_Turn):
			$HBoxContainer/AccuseButton.disabled = false
			$HBoxContainer/SuggestButton.disabled = false
		
		



func _on_DropDownRoom_item_selected(index):
	accusation[0] = $HBoxContainer/VBoxContainer/DropDownRoom.get_item_text(index)


func _on_DropDownCharacter_item_selected(index):
	accusation[2]  = $HBoxContainer/VBoxContainer/DropDownCharacter.get_item_text(index)
	suggestion[2] = $HBoxContainer/VBoxContainer/DropDownCharacter.get_item_text(index)


func _on_DropDownWeapon_item_selected(index):
	accusation[1] = $HBoxContainer/VBoxContainer/DropDownWeapon.get_item_text(index)
	suggestion[1] = $HBoxContainer/VBoxContainer/DropDownWeapon.get_item_text(index)


func _on_AccuseButton_button_up():
	emit_signal("accusationSignal",accusation)


func _on_SuggestButton_button_up():
	print(suggestion)
	emit_signal("suggestionSignal",suggestion)
	$HBoxContainer/SuggestButton.disabled = true
	
