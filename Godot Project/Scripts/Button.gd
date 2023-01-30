extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var button 
var click = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func clicked():
	if click == true:
		click = false
		return -1
	else:
		self.disabled = true
		click = true
		return 1
	print(click)


func isClicked():
	return click 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
