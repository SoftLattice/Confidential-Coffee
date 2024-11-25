extends HandlerCallState

const INITIAL_SPEECH: String = "Looks like you had some customers today.";
const BEGIN_QUESTIONS: String = "Let's see what you remember..."

func _enter_state() -> void:
    await get_tree().create_timer(1.).timeout;
    await handler_call.speak(simple_string_render.bind(INITIAL_SPEECH), 4.).timeout;
    await get_tree().create_timer(1.).timeout;
    await handler_call.speak(simple_string_render.bind(BEGIN_QUESTIONS), 3.).timeout;
    transitioned.emit.call_deferred("idle");