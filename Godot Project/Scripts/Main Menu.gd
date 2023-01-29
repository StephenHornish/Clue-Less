extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var mainGameScene : PackedScene


func _on_New_Game_button_up():
	get_tree().change_scene(mainGameScene.resource_path)
#Test test
