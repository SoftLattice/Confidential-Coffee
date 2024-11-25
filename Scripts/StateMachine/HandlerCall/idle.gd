extends HandlerCallState

@export var wait_time: float = 2.0;

func _enter_state() -> void:
    await get_tree().create_timer(randf_range(0, wait_time)).timeout;
    if handler_call.customer_results.size() == 0:
        print("ALL DONE!");
    else:
        handler_call.active_customer_result = handler_call.customer_results.pop_front();
        transitioned.emit.call_deferred("receiptrequest");