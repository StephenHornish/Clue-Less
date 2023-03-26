extends Control

export var mainGameScene : PackedScene
const DEFAULT_IP = "10.0.0.206"
const DEFAULT_PORT = 4242
const MAX_PLAYERS = 6

var players= {}
var self_data = {name = ''}

func _ready():
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")

func create_server(player_name):
	self_data.name = player_name
	players[1] = self_data
	var net = NetworkedMultiplayerENet.new()
	net.create_server(DEFAULT_PORT,MAX_PLAYERS)
	get_tree().set_network_peer(net)


func connect_to_server(player_name):
	self_data.name = player_name
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	var net = NetworkedMultiplayerENet.new()
	net.create_client(DEFAULT_IP,DEFAULT_PORT)
	get_tree().set_network_peer(net)
	print("connected to Server")

func _connected_to_server():
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info', get_tree().get_network_unique_id(), self_data)
	
remote func _send_player_info(id,info):
	if get_tree().is_network_server():
		for peer_id in players: 
			rpc_id(id, '_send_player_info',peer_id,players [peer_id])
	players[id] = info
	#where you would add the nex player objects
