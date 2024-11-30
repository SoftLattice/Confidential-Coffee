extends Control

signal skip_question();

@export var main_container: Control;

var _is_in: bool = false;
func pop_in() -> void:
    _is_in = true;
    var pop_tween: Tween = create_tween();
    pop_tween.bind_node(self).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE);
    var pop_height = get_viewport().get_visible_rect().size.y;
    pop_tween.tween_property(self, "global_position:y", pop_height, 1.25);

func pop_out() -> void:
    _is_in = false;
    var pop_tween: Tween = create_tween();
    pop_tween.bind_node(self).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD);
    var pop_height = get_viewport().get_visible_rect().size.y + main_container.size.y;
    pop_tween.tween_property(self, "global_position:y", pop_height, 0.75);

func _on_button() -> void:
    if _is_in:
        _is_in = false;
        skip_question.emit.call_deferred();