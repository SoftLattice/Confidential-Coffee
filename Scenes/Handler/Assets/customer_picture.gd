class_name CustomerPicture extends Node2D

@export var slide_time: float = 2;
@export var texture_rect: TextureRect;

@export var debug_texture: Texture;
@export var debug_position: Node2D;

func _ready() -> void:
    set_texture(debug_texture)
    _slide_to(debug_position.global_position, randf_range(-.1,.1));

func set_texture(texture: Texture) -> void:
    texture_rect.texture = texture;

func _slide_to(to_position: Vector2, angle: float) -> void:
    var slide_tween: Tween = create_tween();
    slide_tween.bind_node(self).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).set_parallel(true);
    slide_tween.tween_property(self, "global_position", to_position, slide_time);
    slide_tween.tween_property(self, "rotation", angle, slide_time);
