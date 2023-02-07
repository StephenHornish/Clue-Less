extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 5
var velocity = Vector3.ZERO
var character 
var player 
var destination = Vector3.ZERO
var gap = Vector3.ZERO
onready var position = Vector3.ZERO


# var b = "text"
	
func _ready():
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

	
func move_up():
	move_pawn_direction("Up")
	
func move_down():
	move_pawn_direction("Down")
	
func move_left():
	move_pawn_direction("Left")
	
func move_right():
	move_pawn_direction("Right")
	
func move_secret_passage():
	move_pawn_direction("Secret Passage")	
	
func move_pawn_direction( direction : String) ->void:
	var pawn = get_parent()
	var currtile = pawn.get_tile()
	if(Globals.turn == 1):
		self.set_global_translation(pawn.get_location())
		return
	var pos = currtile.get_moveset().find(direction)
	var adjNodeList = currtile.get_adjacenet()
	var nextTile = Globals.board.get_room(adjNodeList[pos])
	destination = nextTile.get_location()
	self.set_global_translation(nextTile.get_location())
	pawn.set_tile(adjNodeList[pos])
	
func test():
	pass
