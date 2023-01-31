extends Node


var active : bool
var activePlayer

class_name KeyListner
# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	pass # Replace with function body.


# Called when the nod enters the scene tree for the first time.

func _process(delta): 
	if(active):
		if Input.is_action_just_pressed("foward"):
			activePlayer = get_node("../TurnQueue").active_player
			activePlayer.get_child(0).move_foward()
		if Input.is_action_just_pressed("back"):
			activePlayer = get_node("../TurnQueue").active_player
			print(activePlayer)
		if Input.is_action_just_pressed("left") :
			activePlayer = get_node("../TurnQueue").play_turn()
		
		 

func set_active():
	active = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
