class_name PlayerController extends Node3D

@export var speed: float = 2.0;
@export var drag_speed: float = 0.5;
@export var pcam_main: PhantomCamera3D;


func _process(delta: float) -> void:
    var move: float = speed * Input.get_axis("move_left", "move_right");
    move += drag_speed * Input.get_axis("drag_left", "drag_right") * get_viewport().size.x;
    position.x += delta * move;