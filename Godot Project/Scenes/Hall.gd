extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var room = get_parent()
onready var adjacent = [room.get_node("TLHall"),room.get_node("TDMHall"),room.get_node("TRHall")]
onready var isHall = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
