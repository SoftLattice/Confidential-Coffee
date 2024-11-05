class_name PlayerController extends Node3D

@export var speed: float = 2.0;
@export var pcam_main: PhantomCamera3D;

func _process(delta: float) -> void:
	var move: float = speed * Input.get_axis("move_left", "move_right");
	position.x += delta * move;
