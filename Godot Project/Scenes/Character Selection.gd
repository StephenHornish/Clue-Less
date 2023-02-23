extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func buildPlayerView(hand: Array)->void:
	
	for x in range (hand.size()):
		var image_path = "res://Images/Cards/" + str(hand[x].get_name())
		var image = load(image_path)
		var button = TextureButton.new()
		button.texture_normal = image
		if(x<3):
			$HBoxContainer/VBoxContainer.add_child(button)
		if(x>=3):
			$HBoxContainer/VBoxContainer2.add_child(button)
			
