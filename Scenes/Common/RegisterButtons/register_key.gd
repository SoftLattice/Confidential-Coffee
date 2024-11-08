extends Node2D

func _on_collision_area_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
    if event is InputEventMouseButton:
        print("CLICK");


var mouse_in: bool = false;

func _on_collision_area_mouse_entered() -> void:
    mouse_in = true;
    print(mouse_in);

func _on_collision_area_mouse_exited() -> void:
    mouse_in = false;
    print(mouse_in);
