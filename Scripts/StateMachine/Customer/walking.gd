extends CustomerState

@export var jiggle_distance: float = 0.05;
@export var jiggle_period: float = 0.75;
var jiggle_speed: float;

var path_offset: float;

var jiggle_offset: float;
func _enter_state() -> void:
    jiggle_offset = 0;
    jiggle_speed = PI/jiggle_period;

func _on_stop_walking() -> void:
    transitioned.emit("idle");

func _exit_state() -> void:
    # TODO: Make tween set recenter visual_node position to 0
    pass;

func _update(delta: float) -> void:
    jiggle_offset += delta;
    customer.visual_node.position.y = jiggle_distance * absf(sin(jiggle_speed * jiggle_offset));