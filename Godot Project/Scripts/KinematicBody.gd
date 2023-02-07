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
	if(Globals.turn == 1):
		var a = get_parent().get_current_tile()
		var b = a.get_location()
		print(a)
		print(b)
		self.set_global_translation(b)
	var vy = velocity.y
	velocity = Vector3.ZERO
	velocity += transform.basis.z * speed
	velocity.y = vy
	
func move_backward():
	var vy = velocity.y
	velocity = Vector3.ZERO
	velocity += -transform.basis.z * speed
	velocity.y = vy
	
func move_left():
	var vy = velocity.y
	velocity = Vector3.ZERO
	velocity += transform.basis.x * speed
	velocity.y = vy
	
func move_right():
	var vy = velocity.y
	velocity = Vector3.ZERO
	velocity += -transform.basis.x * speed
	velocity.y = vy
	

func test():
	pass
