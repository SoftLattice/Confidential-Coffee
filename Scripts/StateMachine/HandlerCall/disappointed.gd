extends HandlerCallState

signal finished_talking();

const INITIAL_SPEECH: String = "I'm really disappointed... You didn't get to a single customer?";
const WARNING: String = "I expect better from you tomorrow.";

func _enter_state() -> void:
    await get_tree().create_timer(1.).timeout;
    await handler_call.speak(simple_string_render.bind(INITIAL_SPEECH), 5.).timeout;
    await get_tree().create_timer(1.).timeout;
    handler_call.speak(simple_string_render.bind(WARNING), -1);
    finished_talking.emit.call_deferred();

