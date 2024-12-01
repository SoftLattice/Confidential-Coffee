extends AudioStreamPlayer

func fade_out(time: float) -> void:
    var fade_tween: Tween = create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR);
    fade_tween.tween_property(self, "volume_db", -40., time);