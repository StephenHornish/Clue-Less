extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var playSpace : PackedScene
export var creditScene : PackedScene


func _on_New_Game_button_up():
	# Ignore unused return value from change_scene()
	if get_tree().change_scene(playSpace.resource_path) != OK:
		  print ("An unexpected error occured when trying to switch to the Lobby scene")



func _on_Credits_button_up():
	# Ignore unused return value from change_scene()
	if get_tree().change_scene(creditScene.resource_path) != OK:
		  print ("An unexpected error occured when trying to switch to the Credits scene")
	
