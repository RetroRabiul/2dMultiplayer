extends Sprite2D

var speed : float = 100.0
@export var min_x : float
@export var max_x : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > max_x:
		position.x = min_x
