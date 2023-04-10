extends Control

export var mainGameScene : PackedScene
const DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 4242
const MAX_PLAYERS = 6

#Dictionary basically a Hashmap in Java <key,name> where the key is the playerID
# and the name is the players name they entered when the joined the game 
var players= {}
var self_data = {name = '' }

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("connected_to_server",self,"_connected_to_server")
	get_tree().connect("connection_failed", self, "_on_connection_failed")
	get_tree().connect("server_disconnected", self, "_server_disconnected")

#The host will always have a Unique ID as 1 
func create_server(player_name):
	self_data.name = player_name
	players[1] = self_data
	var server = NetworkedMultiplayerENet.new()
	server.create_server(DEFAULT_PORT,MAX_PLAYERS)
	get_tree().set_network_peer(server)
	print("Creating Server")

#Runs for players joining they're player name is passed in and saved to teh self_data class 
func connect_to_server(player_name):
	print("Joining Server")
	self_data.name = player_name
	var client = NetworkedMultiplayerENet.new()
	client.create_client(DEFAULT_IP,DEFAULT_PORT)
	get_tree().set_network_peer(client)


#This function will be called via RPC 
remote func _send_player_info(id,info):
	Globals.numberOfPlayers += 1
	if get_tree().is_network_server():
		for peer_id in players: 
			rpc_id(id, '_send_player_info',peer_id,players [peer_id])
	players[id] = info
	
	#where you would add the nex player objects
	print(players)


func _player_connected(id):
	print('Player Connected: ' + str(id))

#Players Unique ID is used as a key in the self_data object,
# every connected peer has a unqiue ID assigned to it by the OS
func _connected_to_server():
	players[get_tree().get_network_unique_id()] = self_data
	rpc('_send_player_info',get_tree().get_network_unique_id(),self_data)
	print("Successfully connected to the server")

func _on_connection_failed():
	print("Failed To Connect")
	reset_network_connection()
	
func _server_disconnected():
	print("Disconnected from the server")

#Needs to RPC players disconnecting
func _player_disconnected(id):
	print('Player Disconnected: ' + str(id))
	players.erase(id)
	
func reset_network_connection():
	if get_tree().has_network_peer():
		get_tree().network_peer = null

	print("Failed To Connect")
	
