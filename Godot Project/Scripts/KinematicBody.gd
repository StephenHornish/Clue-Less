extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 5
var velocity = Vector3.ZERO
var character 
var player 


# var b = "text"
	
func _ready():
	#set character name based on button press
	#set character color based  on button press
	#remove button select canvas from main scene
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity += gravity * delta 
	velocity = move_and_slide(velocity, Vector3.UP)

	
func move_foward():
	move_pawn_direction("Up")
	
func move_backward():
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
	if(currtile.get_moveset().has(direction)):
		var pos = currtile.get_moveset().find(direction)
		var adjNodeList = currtile.get_adjacenet()
		var nextTile = Globals.board.get_room(adjNodeList[pos])
		self.set_global_translation(nextTile.get_location())
		pawn.set_tile(adjNodeList[pos])
	else:
		print("Invalid Move")
	
func test():
	pass
