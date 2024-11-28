class_name PlayerController extends PathFollow3D

@export var speed: float = 0.5;
@export var drag_speed: float = 0.5;


func _process(delta: float) -> void:
    var move: float = speed * Input.get_axis("move_left", "move_right");
    move += drag_speed * Input.get_axis("drag_left", "drag_right") * get_viewport().size.x;
    progress_ratio = clampf(progress_ratio + delta * move, 0., 1.);
    