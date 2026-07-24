extends Node3D


@export var sway_speed: float = 0.3
@export var sway_amplitude: float = 2.5

var time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * sway_speed
	var angle = sin(time) * deg_to_rad(sway_amplitude)
	rotation.x = angle
	rotation.z = angle
