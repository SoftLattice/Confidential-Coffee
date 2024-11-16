extends CustomerState;

var customer_path: CustomerPath;

var queue_offset: float = 0;
var queue_position: int;
func _enter_state() -> void:
    customer_path = customer.get_customer_path();
    customer.global_position = customer_path.global_position;
    customer_path._on_new_customer(customer);
    _on_queue_update();
    customer_path.customer_dequeued.connect(_on_queue_update);

func _exit_state() -> void:
    customer_path.customer_dequeued.disconnect(_on_queue_update);

func _on_queue_update() -> void:
    queue_position = get_queue_position();

func get_queue_position() -> int:
    return customer_path.get_queue_position(customer);

func _update(delta: float) -> void:
    var obj_offset: float = target_offset();
    if queue_offset < obj_offset:
        if customer.is_customer_idle():
            customer.start_walking.emit.call_deferred();
        queue_offset = move_toward(queue_offset, obj_offset, delta * customer.velocity);

    elif customer.is_customer_walking():
        customer.stop_walking.emit.call_deferred();

    customer.global_position = customer_path.get_global_position_from_offset(queue_offset);

    if is_equal_approx(queue_offset, customer_path.queue_front_offset):
        transitioned.emit("nextup");
        customer.stop_walking.emit.call_deferred();
        customer.at_queue_front.emit.call_deferred();


func target_offset() -> float:
    if queue_position == 0:
        return customer_path.queue_front_offset;
    var ahead_customer: Customer = customer_path.customer_queue[queue_position - 1];
    if is_instance_valid(ahead_customer):
        var ahead_offset: float = customer_path.get_closest_offset_from_global(ahead_customer.global_position);
        return ahead_offset - ahead_customer.radius - customer.radius;
    return 0;
