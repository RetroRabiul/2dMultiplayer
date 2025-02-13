extends CharacterBody2D

@export var player_name : String
@export var player_id : int = 1:
	set(id):
		player_id = id
		$InputSynchronizer.set_multiplayer_authority(id)

@export var max_speed : float = 150.0
@export var turn_rate : float = 2.5
var throttle : float = 0.0

@onready var input = $InputSynchronizer

func _physics_process(delta: float) -> void:
	if multiplayer.is_server():
		_move(delta)
	
func _move (delta) :
	rotate(input.turn_input * turn_rate * delta)
