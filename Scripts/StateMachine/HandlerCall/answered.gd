extends HandlerCallState

const RESPONSES: Array[String] = ["Interesting...", "I see...", "Is that so?"]

@export var wait_time: float = 2.0;

func _enter_state() -> void:
    handler_call.quiet();
    await get_tree().create_timer(randf_range(0, wait_time)).timeout;
    await handler_call.speak(simple_string_render.bind(RESPONSES.pick_random()),2).timeout;

    transitioned.emit.call_deferred("idle");