extends Node3D

signal take_cup();

var _is_clicked: bool = false;
func _on_select_input_event(_camera:Node, event:InputEvent, _event_position:Vector3, _normal:Vector3, _shape_idx:int) -> void:            
    if event is InputEventScreenTouch:
        take_cup.emit.call_deferred();

var _started_click: bool = false;
var _mouse_over: bool = false;
func _process(_delta: float) -> void:
    if Input.is_action_just_released("click_select") and _started_click:
        if _mouse_over:
            take_cup.emit.call_deferred();
        else:
            _started_click = false;

    if Input.is_action_just_pressed("click_select"):
        if _mouse_over:
            _started_click = true;

func _on_select_mouse_exited() -> void:
    _mouse_over = false;

func _on_select_mouse_entered() -> void:
    _mouse_over = true;
