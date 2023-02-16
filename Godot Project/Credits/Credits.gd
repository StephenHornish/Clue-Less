extends Control

# Counter used to keep track of which credit text we are on
var counter = 0

# Background scrolling speed
var scroll_speed: int = 15

# Credit Descriptions & Roles
var credit_list = [
	["Project Manager", "Jade McVay",],
	["Lead Architect", "Irina Bushmanova"],
	["Lead UX Developer", "Steve Hornish"],
	["Data Foundations and Operations", "Claire Deng"],
	["Documentation & Testing", "Renju Mathew"],
	["Map Design", "Steve Hornish"],
	["Music", "https://www.youtube.com/watch?v=0uaIuzOaWpk \n Test 2"],
	["Credit To", "https://www.youtube.com/@DCRKev"],
	["TanGodot", "Thank you for Playing!"]
]

# Called when the node enters the scene tree for the first time. Starts Timer and Music
func _ready() -> void:
	$AudioStreamPlayer.play()
	$Timer.start()

# Scrolling background image
func _process(delta: float) -> void:
		$ParallaxBackground/ParallaxLayer.motion_offset.x -= scroll_speed * delta

#Displays Credit list and plays animation for fading text and background box
func _on_Timer_timeout() -> void:
	 $VBoxContainer/Title.text = credit_list[counter][0]
	 $VBoxContainer/Name.text = credit_list[counter][1]
	 $AnimationPlayer.play("Fade in and out")
	 $AnimationPlayer2.play("DialogBoxFade")
	 counter += 1
	 if counter == credit_list.size():
			$Timer.stop()

