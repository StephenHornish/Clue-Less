extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var room = get_parent()
onready var adjacent = [room.get_node("Conservatory"),room.get_node("Library")]
onready var isHall = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass