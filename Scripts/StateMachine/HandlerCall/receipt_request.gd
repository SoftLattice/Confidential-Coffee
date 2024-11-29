extends HandlerCallState

const RECEIPT_REQUEST: String = "Send me this person's receipt.";

signal wrong_answer();
signal right_answer();

var _active_mugshot: CustomerPicture;
func _enter_state() -> void:
    _active_mugshot = handler_call._spawn_mugshot(handler_call.active_customer_result);
    await get_tree().create_timer(1.).timeout;
    handler_call.speak(simple_string_render.bind(RECEIPT_REQUEST),-1);
    handler_call.request_picture.emit.call_deferred();

func _exit_state() -> void:
    handler_call.stop_picture.emit.call_deferred();

func _on_receipt_picture(customer_result:CustomerResult) -> void:
    if customer_result == handler_call.active_customer_result:
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
