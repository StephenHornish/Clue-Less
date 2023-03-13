extends HBoxContainer
# ["Left","Up","Right,"Down","Secret Passage ]
var playerID
var character
export var mainGameScene : PackedScene

func buildMoves(moveSet:Array) -> void:
	if(Globals.turn == 1):
		print("Buttons: " + character)
		setColors()
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
	#have to connect to a random variable or else the compiler complains 
	var _random_var 
	_random_var =$LeftContainer/LeftButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_LeftButton_button_up")
	_random_var =$VBoxContainer/DownContainer/DownButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_DownButton_button_up")
	_random_var =$VBoxContainer/UpContainer/UpButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_UpButton_button_up")
	_random_var =$RightContainer/RightButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_RightButton_button_up")
	_random_var =$EndTurnContainer/EndTurn.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_EndTurn_button_up")
	_random_var =$SecretContainer/SecretButton.connect("button_up", get_node("/root/Boardgame3Tris/TurnQueue"), "_on_SecretButton_button_up")
	_random_var =$EnterContainer/EnterButton.connect("button_up",get_node("/root/Boardgame3Tris/TurnQueue"),"_on_EnterButton_button_up")
	get_child(0).hide()
	get_child(1).hide()
	get_child(2).hide()
	get_child(3).hide()
	get_child(4).hide()
	
	
func setColors() -> void: 
	match character:
		"Peacock":
			$VBoxContainer/UpContainer/UpButton.modulate = Color(0.5, 0.7, 1.0)
			$LeftContainer/LeftButton.modulate  = Color(0.5, 0.7, 1.0)
			$RightContainer/RightButton.modulate  = Color(0.5, 0.7, 1.0)
			$VBoxContainer/DownContainer/DownButton.modulate  = Color(0.5, 0.7, 1.0)
			$SecretContainer/SecretButton.modulate  = Color(0.5, 0.7, 1.0)
		"Scarlett":
			$VBoxContainer/UpContainer/UpButton.modulate = Color(0.858824, 0.439216, 0.576471, 1)
			$LeftContainer/LeftButton.modulate  = Color(0.858824, 0.439216, 0.576471, 1)
			$RightContainer/RightButton.modulate  = Color(0.858824, 0.439216, 0.576471, 1)
			$VBoxContainer/DownContainer/DownButton.modulate  = Color(0.858824, 0.439216, 0.576471, 1)
			$SecretContainer/SecretButton.modulate  = Color(0.858824, 0.439216, 0.576471, 1)
		"Plumb":
			$VBoxContainer/UpContainer/UpButton.modulate = Color(0.576471, 0.439216, 0.858824, 1)
			$LeftContainer/LeftButton.modulate  = Color(0.576471, 0.439216, 0.858824, 1)
			$RightContainer/RightButton.modulate  =Color(0.576471, 0.439216, 0.858824, 1)
			$VBoxContainer/DownContainer/DownButton.modulate  = Color(0.576471, 0.439216, 0.858824, 1)
			$SecretContainer/SecretButton.modulate  = Color(0.576471, 0.439216, 0.858824, 1)
		"Mustard":
			$VBoxContainer/UpContainer/UpButton.modulate = Color(1.0, 0.9, 0.5)
			$LeftContainer/LeftButton.modulate  = Color(1.0, 0.9, 0.5)
			$RightContainer/RightButton.modulate  = Color(1.0, 0.9, 0.5)
			$VBoxContainer/DownContainer/DownButton.modulate  = Color(1.0, 0.9, 0.5)
			$SecretContainer/SecretButton.modulate  = Color(1.0, 0.9, 0.5)
		"Green":
			$VBoxContainer/UpContainer/UpButton.modulate = Color(0.5, 1.0, 0.5)
			$LeftContainer/LeftButton.modulate  = Color(0.5, 1.0, 0.5)
			$RightContainer/RightButton.modulate  = Color(0.5, 1.0, 0.5)
			$VBoxContainer/DownContainer/DownButton.modulate  = Color(0.5, 1.0, 0.5)
			$SecretContainer/SecretButton.modulate  = Color(0.5, 1.0, 0.5)

			
	

