extends SpawnedNode

@export var velocity: float = 5.;
@export var buoyancy: float = 2.;

var _container: LiquidContainer;
var _target_position: Node3D;
var in_container: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.

var _velocity: float = 0;
func _process(delta: float) -> void:
    if in_container:
        global_position = global_position.lerp(
                _target_position.global_position, move_toward(0.,1.,buoyancy * delta)
            );
    elif _container != null:
        _velocity += velocity * delta;
        var actual_target: Vector3 = lerp(_container.global_position, _target_position.global_position, 0.5);
        global_position = global_position.move_toward(actual_target, delta * _velocity);
        if global_position.is_equal_approx(actual_target):
            in_container = true;


func _set_container(container: HeldRecipe) -> void:
    if container is not LiquidContainer:
        return;
    _container = container;
    _target_position = _container.active_liquid_position;
    reparent(_container, true);
