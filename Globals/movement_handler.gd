extends Node

@export var minimum_dead_time: float = 0.1;

var dead_time: float = 0.;
func _ready() -> void:
    pass;

func _process(delta: float) -> void:
    if dead_time > 0:
        dead_time = move_toward(dead_time, 0, delta);
        if is_equal_approx(dead_time,0):
            Input.action_release("drag_right");
            Input.action_release("drag_left");
            dead_time = -1;

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventScreenDrag:
        parse_drag_movement(event);

func parse_drag_movement(event: InputEventScreenDrag) -> void:
    dead_time = minimum_dead_time;
    var relative_drag: float = event.relative.x / float(get_viewport().size.x);
    Input.action_press("drag_left", relative_drag)
    Input.action_press("drag_right", -relative_drag);
    get_viewport().set_input_as_handled();
