extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var room = get_parent()
onready var adjacent = [room.get_node("MRHall"),room.get_node("MLHall"),room.get_node("TDMHall"), room.get_node("BUMHall")]
onready var isHall = false
onready var location = Vector3( -2.3 ,0, -0.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
