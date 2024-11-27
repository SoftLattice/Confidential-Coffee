class_name CustomerPicture extends Node2D

signal drag_start();
signal drag_stop();

@export var slide_time: float = 2;
@export var texture_rect: TextureRect;
@export var container: Container;

@export var select_area: Area2D;
@export var slide_angle_jitter: float = 0.1;

func set_texture(texture: Texture) -> void:
    texture_rect.texture = texture;

func slide_to(to_position: Vector2) -> Tween:
    var angle: float = randf_range(-slide_angle_jitter,slide_angle_jitter);
    var slide_tween: Tween = create_tween();
    slide_tween.bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).set_parallel(true);
    slide_tween.tween_property(self, "global_position", to_position, slide_time);
    slide_tween.tween_property(self, "rotation", angle, slide_time);
    slide_tween.set_parallel(false);
    slide_tween.tween_property(select_area, "input_pickable", true, 0);
    return slide_tween;
    
var _is_dragging: bool = false;
var _relative_position: Vector2 = Vector2.ZERO;
func _on_select_input_event(_viewport:Node, event:InputEvent, _shape_idx:int) -> void:
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

func get_size() -> Vector2:
    return container.size;