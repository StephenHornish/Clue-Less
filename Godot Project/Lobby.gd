extends Control

export var mainGameScene : PackedScene



func _ready():
	get_tree().connect("network_peer_connected", self, "Success")

func _on_Host_button_up():
	var net = NetworkedMultiplayerENet.new()
	net.create_server(4242,6)
	get_tree().network_peer = net


func _on_Join_button_up():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("10.0.0.206",4242)
	get_tree().network_peer = net

func Success(id):
	Globals.player_ids.append(id)
	if (Globals.player_ids.size() > 1):
		print("Fudge")
		get_tree().change_scene(mainGameScene.resource_path)
		queue_free()
