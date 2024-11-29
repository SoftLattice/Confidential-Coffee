extends HandlerCallState

const RECEIPT_REQUEST: String = "What did this person tell you?";

signal wrong_answer();
signal right_answer();

var _active_mugshot: CustomerPicture;
func _enter_state() -> void:
    _active_mugshot = handler_call._spawn_mugshot(handler_call.active_customer_result);
    await get_tree().create_timer(1.).timeout;
    handler_call.speak(simple_string_render.bind(RECEIPT_REQUEST),-1);
    handler_call.request_quote.emit.call_deferred();


func _on_submit_quote(phrase_seed: Array[int]) -> void:
    var target_phrase: Array[int] = handler_call.active_customer_result.phrase_seed;
    var _right_answer: bool = true;
    if phrase_seed.size() != target_phrase.size():
        _right_answer = false;
    else:
        for i in range(phrase_seed.size()):
            if phrase_seed[i] != target_phrase[i]:
                _right_answer = false;
                break;

    if _right_answer:
        right_answer.emit.call_deferred();
    else:
        wrong_answer.emit.call_deferred();

    var exit_tween: Tween = _active_mugshot.slide_to(-2*_active_mugshot.get_size());
    exit_tween.tween_callback(_active_mugshot.queue_free);

    transitioned.emit.call_deferred("answered");

func _on_skip_question() -> void:
    if _is_active_state:
        var exit_tween: Tween = _active_mugshot.slide_to(-2*_active_mugshot.get_size());
        exit_tween.tween_callback(_active_mugshot.queue_free);
        transitioned.emit.call_deferred("skipped");
