extends Node

const MAX_CLIENTS : int = 4

@onready var network_ui = $NetworkUI
@onready var ip_input = $NetworkUI/VBoxContainer/IPInput
@onready var port_input = $NetworkUI/VBoxContainer/PortInput

var local_username : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func start_host():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(int(port_input.text), MAX_CLIENTS)
	multiplayer.multiplayer_peer = peer
	
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	
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

func _on_player_disconnected (id : int):
	print("Player %s left the game." % id)


func _connected_the_server():
	print("Connected the server.")
	network_ui.visible = false

func _connection_failed():
	print("Connection failed!")

func _server_disconnected():
	print("Server Disconnected.")
	network_ui.visible = true

func _on_username_input_text_changed(new_text: String) -> void:
	local_username = new_text
