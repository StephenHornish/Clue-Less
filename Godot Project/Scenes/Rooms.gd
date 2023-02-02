extends Node


onready var roomArray = ["BallRoom","Conservatory","Library","Study","Hall","Lounge","DinningRoom","Kitchen","BillardsRoom"]
onready var Halls = get_parent().get_node("Halls")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_adjacent_nodes(node : Node):
	print(node.adjacent)
	return node.adjacent


