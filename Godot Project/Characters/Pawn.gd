extends Spatial

enum Moveset {Left, Right, Up, Down, Accuse}
onready var activePlayer : bool  = false
onready var location : String
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

func set_location(loc):
	location = loc

func get_location():
	return location
