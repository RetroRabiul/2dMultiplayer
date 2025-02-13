extends Node

const MAX_CLIENTS : int = 4

@onready var network_ui = $NetworkUI
@onready var ip_input = $NetworkUI/VBoxContainer/IPInput
@onready var port_input = $NetworkUI/VBoxContainer/PortInput

var player_scene = preload("res://Scenes/Player.tscn")
@onready var spawned_nodes = $SpawnedNodes

var local_username : String

var spawn_x_range : float = 350
var spawn_y_range : float = 200



func start_host():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(int(port_input.text), MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	_on_player_connected(multiplayer.get_unique_id())
	
	network_ui.visible = false
	


func start_client():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip_input.text, int(port_input.text))
	multiplayer.multiplayer_peer = peer
	
	multiplayer.connected_to_server.connect(_connected_the_server)
	multiplayer.connection_failed.connect(_connection_failed)
	multiplayer.server_disconnected.connect(_server_disconnected)
	

func _on_player_connected (id : int):
	print("Player %s joined the game." % id)
	
	var player = player_scene.instantiate()
	player.position = _get_random_spawn_position()
	player.name = str(id)
	player.player_id = id
	spawned_nodes.add_child(player, true)

func _on_player_disconnected (id : int):
	print("Player %s left the game." % id)
	
	if not spawned_nodes.has_node(str(id)):
		return
	
	spawned_nodes.get_node(str(id)).queue_free()


func _connected_the_server():
	print("Connected the server.")
	network_ui.visible = false

func _connection_failed():
	print("Connection failed!")

func _server_disconnected():
	print("Server Disconnected.")
	network_ui.visible = true

func _get_random_spawn_position () -> Vector2:
	return Vector2(randf_range(-spawn_x_range, spawn_x_range), randf_range(-spawn_y_range, spawn_y_range))
	

func _on_username_input_text_changed(new_text: String) -> void:
	local_username = new_text
