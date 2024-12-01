extends HandlerCallState

const RESPONSES: Array[String] = ["That's OK.", "Pay closer attention.", "Maybe tomorrow."]

@export var wait_time: float = 1.5;

func _enter_state() -> void:
    handler_call.quiet();
    await get_tree().create_timer(randf_range(0, wait_time)).timeout;
    await handler_call.speak(simple_string_render.bind(RESPONSES.pick_random()),1.5).timeout;

    transitioned.emit.call_deferred("idle");