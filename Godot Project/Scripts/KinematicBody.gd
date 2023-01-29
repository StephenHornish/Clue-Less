extends KinematicBody

export var gravity = Vector3.DOWN * 10
export var speed = 10
var velocity = Vector3.ZERO
var character 


# var b = "text"
	
func _ready():
	#set character name based on button press
	#set character color based  on button press
	#remove button select canvas from main scene
	pass

func _physics_process(delta):
	velocity += gravity * delta 
	get_input()
	velocity = move_and_slide(velocity, Vector3.UP)
# Called when the nod enters the scene tree for the first time.

func get_input(): 
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_just_pressed("foward"):
		velocity += -transform.basis.z * speed
	if Input.is_action_just_pressed("back"):
		velocity += transform.basis.z * speed
		#mat.set_material_overrides(will)
		
		 
	
	velocity.y = vy


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
