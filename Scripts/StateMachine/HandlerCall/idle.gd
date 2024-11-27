extends HandlerCallState

@export var wait_time: float = 2.0;
@export var quote_probability: float = 0.5;

func _enter_state() -> void:
    await get_tree().create_timer(randf_range(0, wait_time)).timeout;
    if handler_call.customer_results.size() == 0:
        transitioned.emit.call_deferred("finished");
    else:
        handler_call.active_customer_result = handler_call.customer_results.pop_front();
        # Random chance to ask for quote instead
        if handler_call.active_customer_result.phrase_seed and randf() < quote_probability:
            transitioned.emit.call_deferred("quoterequest");
        else:
            transitioned.emit.call_deferred("receiptrequest");