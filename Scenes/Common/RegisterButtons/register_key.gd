extends Node2D

signal pressed();

@export var sprite: Sprite2D;

func _on_collision_area_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
    if event is InputEventMouseButton:
        if event.is_pressed():
            print("CLICKED!");
            pressed.emit();

var mouse_in: bool = false;
func _on_collision_area_mouse_entered() -> void:
    mouse_in = true;

func _on_collision_area_mouse_exited() -> void:
    mouse_in = false;


func _on_touch_screen_button_pressed() -> void:
    print("TOUCHED!");
