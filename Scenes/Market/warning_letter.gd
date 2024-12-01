extends Control

@export var checkbox_container: Control;
@export var checked_texture: Texture;
@export var slide_spot: Node2D;
@export var slide_end: Node2D;
var checkboxes: Array[TextureRect];

var _to_jail: bool = false;
func _ready() -> void:
    checkboxes.assign(checkbox_container.get_children());
    for i in range(HandlerManager.bad_intel_count):
        if i >= checkboxes.size():
            break;
        checkboxes[i].texture = checked_texture;

    if HandlerManager.bad_intel_count >= checkboxes.size():
        _to_jail = true;
    if HandlerManager.warn_player:
        show_warning.call_deferred();

func show_warning() -> void:
    var slide_tween: Tween = create_tween();
    slide_tween.bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD);
    slide_tween.tween_property(self, "global_position", slide_spot.global_position, 0.75);
    slide_tween.tween_interval(3.);
    slide_tween.tween_property(self, "global_position", slide_end.global_position, 0.75);

    if _to_jail:
        await slide_tween.finished;
        SceneList.load_scene(SceneList.game_over_arrest);

