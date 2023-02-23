extends MarginContainer

func buildPlayerView(hand: Array)->void:
	
	for x in range (hand.size()):
		var image_path = "res://Images/Cards/" + str(hand[x].get_name()+".png")
		var image = load(image_path)
		var button = TextureButton.new()
		button.texture_normal = image
		if(x<3):
			$HBoxContainer/VBoxContainer.add_child(button)
		if(x>=3):
			$HBoxContainer/VBoxContainer2.add_child(button)
			
