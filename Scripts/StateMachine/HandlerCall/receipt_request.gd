extends HandlerCallState

const RECEIPT_REQUEST: String = "What did this person order?";

func _enter_state() -> void:
    handler_call._spawn_mugshot(handler_call.active_customer_result);
    await get_tree().create_timer(1.).timeout;
    handler_call.speak(simple_string_render.bind(RECEIPT_REQUEST),-1);
    handler_call.request_picture.emit.call_deferred();

func _exit_state() -> void:
    handler_call.stop_picture.emit.call_deferred();

func _on_receipt_picture(customer_result:CustomerResult) -> void:
    print(customer_result == handler_call.active_customer_result);
    transitioned.emit.call_deferred("answered");

