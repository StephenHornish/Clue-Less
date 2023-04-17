extends MarginContainer

var playerID
var cardclicked
var suggestionMade = false
var weapon
var room
var player

func buildPlayerView(hand: Array)->void:
	
	for x in range (hand.size()):
		var image_path = "res://Images/Cards/" + str(hand[x].get_name()+".png")
		var image = load(image_path)
		var button = TextureButton.new()
		button.texture_normal = image
		button.connect("pressed",self,"_on_button_pressed",[hand[x].get_name()])
		if(x<3):
			$HBoxContainer/VBoxContainer.add_child(button)
		if(x>=3):
			$HBoxContainer/VBoxContainer2.add_child(button)
			
			
	#This function needs to see if the clicked card is a valid counter to a suggestion if so 
func _on_button_pressed(var name):
	# Perform the desired action here
	if(suggestionMade):
		return
	if(weapon == name || room == name || player == name):
		get_parent().counterSuggestion = cardclicked
		print("RAN")
		suggestionMade = true

func requestSuggestion(_weapon,_room,_player):
	weapon = _weapon
	room = _room
	player = _player
