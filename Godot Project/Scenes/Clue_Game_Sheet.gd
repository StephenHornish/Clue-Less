extends Control

var playerID

func _ready():
	get_child(0).get_child(0).emit_signal("pressed")
