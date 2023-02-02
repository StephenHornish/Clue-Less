extends Spatial

enum Moveset {Left, Right, Up, Down, Accuse}
onready var activePlayer : bool  = false
onready var location : String
onready var currNode : Node
onready var adjacent
var playID : String

func _ready():
	pass # 

func set_color(color : Color):
	var newMaterial = SpatialMaterial.new()
	newMaterial.albedo_color = color
	$"KinematicBody/PawnMesh".material_override = newMaterial
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_active():
	activePlayer = true
	
func set_inactive():
	activePlayer = false

func set_playerID(id):
	playID = id

func get_ID():
	return playID	

func set_location(loc : String):
	location = loc
	var playArea = get_parent().get_parent().get_child(1)
	var rooms = get_parent().get_parent().get_child(1).get_child(4)
	currNode = rooms.get_node(loc)
	adjacent = rooms.get_node(loc).adjacent
	print(currNode)
	print(adjacent)

func get_location():
	return location

func get_adjacent():
	return adjacent
