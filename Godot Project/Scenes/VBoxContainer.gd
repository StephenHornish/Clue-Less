extends VBoxContainer

func _ready():
	# Get the VBoxContainer and all the TextureRect nodes
	var vbox = self
	var textures = vbox.get_children()

	# Calculate the size of each TextureRect
	var available_height = vbox.get_size().y / textures.size()
	var size = Vector2(available_height, available_height)

	# Set the size of each TextureRect
	for texture in textures:
		texture.set_size(size)
