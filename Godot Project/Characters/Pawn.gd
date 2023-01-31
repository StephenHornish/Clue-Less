extends Spatial


onready var activePlayer : bool  = false
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

	
