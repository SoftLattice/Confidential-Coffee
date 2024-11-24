class_name CallReceipt extends Control

signal drag_start();
signal drag_stop();

@export var texture_rect: TextureRect;

var _is_dragging: bool = false;
var _relative_position: Vector2 = Vector2.ZERO;
func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        _is_dragging = event.is_pressed();
        if _is_dragging:
            drag_start.emit.call_deferred();
        else:
            drag_stop.emit.call_deferred();

        _relative_position = global_position - get_viewport().get_mouse_position();

func _process(_delta: float) -> void:
    if _is_dragging:
        var new_global_position = _relative_position + get_viewport().get_mouse_position();
        new_global_position = new_global_position.min(get_viewport().get_visible_rect().size);
        new_global_position = new_global_position.max(Vector2.ZERO);
        global_position = new_global_position;