extends Node3D

signal start_steam();
signal stop_steam();

@export var visual: Node3D;

var _is_busy: bool = false;
func _on_click() -> void:
    if !_is_busy:
        _is_busy = true;
        start_steam.emit.call_deferred();
        var spin_tween: Tween = create_tween();
        spin_tween.bind_node(visual).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD);
        spin_tween.tween_property(visual,"rotation:x",-PI,0.5);

func _steam_finished() -> void:
    _is_busy = false;
    stop_steam.emit.call_deferred();
    var spin_tween: Tween = create_tween();
    spin_tween.bind_node(visual).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD);
    spin_tween.tween_property(visual,"rotation:x",0.,0.5);