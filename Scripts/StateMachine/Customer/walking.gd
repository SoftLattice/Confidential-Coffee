extends CustomerState

@export var walking_speed: float = 1.0;

@export var jiggle_distance: float = 0.05;
@export var jiggle_speed: float = 4.5;

var current_path: Path3D;
var path_offset: float;

var jiggle_offset: float;
func _enter_state() -> void:
    jiggle_offset = 0;
    current_path = customer.cafe_path.motion_path;
    var customer_position: Vector3 = current_path.to_local(customer.global_position);
    path_offset = maxf(current_path.curve.get_closest_offset(customer_position), 0.0);

func _on_stop_walking() -> void:
    transitioned.emit("idle");

func _exit_state() -> void:
    # TODO: Make tween set recenter visual_node position to 0
    pass;

func _update(delta: float) -> void:
    jiggle_offset += delta;
    customer.visual_node.position.y = jiggle_distance * absf(sin(jiggle_speed * jiggle_offset));
    path_offset += delta * walking_speed;
    customer.global_position = current_path.to_global(current_path.curve.sample_baked(path_offset));
    
