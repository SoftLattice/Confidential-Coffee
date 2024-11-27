extends HandlerCallState

signal finished_talking();

const INITIAL_SPEECH: String = "I'll confer with my other sources.";
const END_CALL: String = "You'll be reimbursed accordingly."

func _enter_state() -> void:
    await get_tree().create_timer(1.).timeout;
    await handler_call.speak(simple_string_render.bind(INITIAL_SPEECH), 3.).timeout;
    await get_tree().create_timer(1.).timeout;
    handler_call.speak(simple_string_render.bind(END_CALL), 3.);
    finished_talking.emit.call_deferred();