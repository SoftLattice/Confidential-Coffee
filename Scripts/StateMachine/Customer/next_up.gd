extends CustomerState

signal leaving_queue();
var customer_path: CustomerPath;

var counter_open: bool;
var queue_offset: float;

func _enter_state() -> void:
    counter_open = false;
    customer_path = customer.get_customer_path();
    queue_offset = customer_path.queue_front_offset;

func _on_approach_counter() -> void:
    counter_open = true;

func _update(delta: float) -> void:
    if counter_open:
        if queue_offset < customer_path.counter_offset:
            queue_offset = move_toward(queue_offset, customer_path.counter_offset, delta * customer.velocity);
        if !customer.is_customer_walking():
            customer.start_walking.emit.call_deferred();

    customer.global_position = customer_path.get_global_position_from_offset(queue_offset);

    if is_equal_approx(queue_offset, customer_path.counter_offset):
        leaving_queue.emit();
        customer.stop_walking.emit.call_deferred();
        transitioned.emit("ordering");