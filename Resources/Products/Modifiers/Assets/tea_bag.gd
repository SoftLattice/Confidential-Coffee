extends Node3D

@export var velocity: float = 0.5;
var container: LiquidContainer;
var _target_position: Node3D;
var in_container: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

var _velocity: float = 0;
func _process(delta: float) -> void:
    if in_container:
        global_position = global_position.lerp(
                _target_position.global_position, move_toward(0.,1.,velocity*delta)
            );
    elif container != null:
        _velocity += velocity * delta;
        var actual_target: Vector3 = lerp(container.global_position, _target_position.global_position, 0.9);
        global_position = global_position.move_toward(actual_target, _velocity);
        if global_position.is_equal_approx(actual_target):
            in_container = true;

    if Input.is_action_just_pressed("debug"):
        _set_liquid_container(get_parent());

func _set_liquid_container(liquid_container: LiquidContainer) -> void:
    container = liquid_container;
    _target_position = container.active_liquid_position;
    reparent(liquid_container, true);
