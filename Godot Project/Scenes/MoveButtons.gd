extends HBoxContainer
# ["Left","Up","Right,"Down","Secret Passage ]
var playerID

func buildMoves() -> void:
	if(Globals.turn == 1):
		get_child(0).hide()
		get_child(1).hide()
		get_child(2).hide()
		get_child(3).hide()
	else:
		get_child(0).show()
		get_child(1).show()
		get_child(2).show()
		get_child(3).show()
		get_child(5).hide()
			
func releaseButtons()->void:
	queue_free_children(self)
	free_children(self)

static func queue_free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.queue_free()
		
static func free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.free()

func _on_left_pressed():
	print("Left Button pressed!")	
func _on_right_pressed():
	print("Right Button presssed!")
func _on_up_pressed():
	print("Up Button presssed!")
func _on_down_pressed():
	print("Down Button presssed!")
func _on_secret_pressed():
	print("Secret Passage Button presssed!")
	
	
