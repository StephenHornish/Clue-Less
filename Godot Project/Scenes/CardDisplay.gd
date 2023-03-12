extends MarginContainer

var playerID

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
	print("Button clicked with texture:" + name)
	print(playerID)
