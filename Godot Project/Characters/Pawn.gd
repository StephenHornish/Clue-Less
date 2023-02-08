extends Spatial


onready var activePlayer : bool  = false
onready var tile : Tile
onready var moveset : Array
onready var adjacent : Array
var playID : String
var playerNumber: int


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

func set_tile(t: Tile):
	tile  = t
	moveset = tile.get_moveset()

func get_tile() -> Tile:
	return tile
	
func get_location()-> Vector3:
	return tile.get_location()

func get_current_tile() -> Tile:
	return tile

func get_adjacent() -> Array:
	return adjacent
	
func get_moveset() -> Array:
	return adjacent

	
