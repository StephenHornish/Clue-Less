extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 200
var velocity = Vector3.ZERO
var character 
var player 
var destination = Vector3.ZERO
var gap = Vector3.ZERO
onready var position = Vector3.ZERO
var stopPoint


# var b = "text"
	
func _ready():
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	#Unit vector pointing at the target position from the characters position
	#var direction = position.direction_to(destination)
	#velocity = direction * speed
	#gap = destination.distance_to(self.global_transform.origin)
	#print(gap)
	#move_and_slide(velocity)
	#if(gap < .5):
		#self.set_global_translation(destination)
		#velocity = Vector3.ZERO
	pass
	
func move_room_suggestion(_tile):
	var pawn = get_parent()
	var currtile = pawn.get_tile()
	var nextTile = _tile
	destination = nextTile.get_location()
	self.set_global_translation(destination + pawn_offset(nextTile))
	currtile.remove_occupant(pawn.get_ID())
	nextTile.set_occupant(pawn.get_ID())
	pawn.set_tile(nextTile)
	Globals.currentTilesArray[pawn.playerNumber] = nextTile
	
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
	position = currtile.get_location()
	var pos = currtile.get_moveset().find(direction)
	var adjNodeList = currtile.get_adjacenet()
	var nextTile = adjNodeList[pos]
	destination = nextTile.get_location()
	self.set_global_translation(destination + pawn_offset(nextTile))
	currtile.remove_occupant(pawn.get_ID())
	nextTile.set_occupant(pawn.get_ID())
	pawn.set_tile(nextTile)
	Globals.currentTilesArray[pawn.get_turn_order()] = nextTile
	
func test():
	pass
	
#takes in teh adjacent tile calculates if an offset is needed and applies it
func pawn_offset(tile : Tile)->Vector3:
	if(tile.is_Hall()):
		return Vector3.ZERO
	var counter := 0
	for x in tile.get_occupants():
		if(x == tile.Empty):
			return Globals.offSetArray[counter]
		counter += 1
	return Vector3.ZERO
		
		
