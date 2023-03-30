extends Control

export var mainGameScene : PackedScene
const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 4242
const MAX_PLAYERS = 6

var players= {}
var self_data = {name = ''}

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

func create_server(player_name):
	self_data.name = player_name
	players[1] = self_data
	var net = NetworkedMultiplayerENet.new()
	net.create_server(DEFAULT_PORT,MAX_PLAYERS)
	get_tree().set_network_peer(net)
	print("Creating Server")


func connect_to_server(player_name):
	print("Joining Server")
	self_data.name = player_name
	var net = NetworkedMultiplayerENet.new()
	net.create_client(DEFAULT_IP,DEFAULT_PORT)
	get_tree().set_network_peer(net)

	
remote func _send_player_info(id,info):
	if get_tree().is_network_server():
		for peer_id in players: 
			rpc_id(id, '_send_player_info',peer_id,players [peer_id])
	players[id] = info
	#where you would add the nex player objects


func _player_connected(id):
	print('Player Connected: ' + str(id))

func _connected_to_server():
	print("Successfully connected to the server")

func _on_connection_failed():
	print("Failed To Connect")
	
func _server_disconnected():
	print("Disconnected from the server")

func _player_disconnected(id):
	print('Player Disconnected: ' + str(id))
	players.erase(id)
	
func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null
