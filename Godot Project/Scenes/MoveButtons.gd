extends HBoxContainer
# ["Left","Up","Right,"Down","Secret Passage ]
var playerID
export var mainGameScene : PackedScene
signal leftbut

func buildMoves(moveSet:Array) -> void:
	if(Globals.turn == 1):
		pass
	if(Globals.turn == 2):
		setUpButtons(get_child(5))
	$EndTurnContainer/EndTurn.disabled = false
	print(moveSet)
	for move in moveSet:
		match move: 
			"Up":
				$VBoxContainer/UpContainer/UpButton.disabled = false
			"Left":
				$LeftContainer/LeftButton.disabled = false
			"Right":
				$RightContainer/RightButton.disabled = false
			"Down":
				$VBoxContainer/DownContainer/DownButton.disabled = false
			"Secret Passage":
				$SecretContainer/SecretButton.disabled = false


func disableButtons()->void: 
	$VBoxContainer/UpContainer/UpButton.disabled = true
	$LeftContainer/LeftButton.disabled = true
	$RightContainer/RightButton.disabled = true
	$VBoxContainer/DownContainer/DownButton.disabled = true
	$SecretContainer/SecretButton.disabled = true
	$EndTurnContainer/EndTurn.disabled = true

func disableMoveButtons()->void:
	$VBoxContainer/UpContainer/UpButton.disabled = true
	$LeftContainer/LeftButton.disabled = true
	$RightContainer/RightButton.disabled = true
	$VBoxContainer/DownContainer/DownButton.disabled = true
	$SecretContainer/SecretButton.disabled = true
	
func setUpButtons(node : Node)->void:
	get_child(0).show()
	get_child(1).show()
	get_child(2).show()
	get_child(3).show()
	get_child(4).show()
	queue_free_children(node)
	free_children(node)


static func queue_free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.queue_free()
		
static func free_children(node: Node) -> void:
	for idx in node.get_child_count():
		node.free()

func connectButtons():
	$LeftContainer/LeftButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_LeftButton_button_up")
	$VBoxContainer/DownContainer/DownButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_DownButton_button_up")
	$VBoxContainer/UpContainer/UpButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_UpButton_button_up")
	$RightContainer/RightButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_RightButton_button_up")
	$EndTurnContainer/EndTurn.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_EndTurn_button_up")
	$SecretContainer/SecretButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_SecretButton_button_up")
	$EnterContainer/EnterButton.connect("button_up",get_node("/root/Boardgame3Tris/TurnQueue"),"_on_EnterButton_button_up")
	get_child(0).hide()
	get_child(1).hide()
	get_child(2).hide()
	get_child(3).hide()
	get_child(4).hide()
	
	


