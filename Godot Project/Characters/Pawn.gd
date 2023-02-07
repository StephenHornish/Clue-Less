extends Spatial


onready var activePlayer : bool  = false
onready var tile
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

func set_tile(room: String):
	tile  = Globals.board.get_room(room)
	print(tile)

func get_current_tile():
	return tile

func get_adjacent() -> Array:
	return adjacent

