extends Spatial

enum Moveset {Left, Right, Up, Down, Accuse}
onready var activePlayer : bool  = false
onready var location : String
onready var currNode : Node
onready var adjacent : Array
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
func set_active() -> void:
	activePlayer = true
	
func set_inactive() -> void:
	activePlayer = false

func set_playerID(id : String) -> void:
	playID = id

func get_ID() -> String:
	return playID	

func set_location(room: String):
	var roomref = get_parent().get_parent().RoomReference
	currNode = roomref.get_node(room)
	var kin = get_child(0)
	kin.translation = currNode.location
	print(currNode)
	adjacent = currNode.adjacent
	print(adjacent)

func get_location() -> String:
	return location

func get_adjacent() -> Array:
	return adjacent
