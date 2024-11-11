extends CafePath

@export var customer_spacing: float = 1.2
@export var queued_customers: Array[Customer];

var customer_flags: Array[int];

const PACKED_CUSTOMER: int = 1;

func _ready() -> void:
    customer_flags.assign(
            queued_customers.map(func(_customer: Customer) -> int: return 0)
        );

func _on_queue_move() -> void:
    # If a customer is available, push them to the next queue
    var active_customer: Customer = queued_customers.pop_front();
    customer_flags.pop_front();
    if is_instance_valid(active_customer):
        active_customer.change_paths(next_path);

    # Mark the first in queue as not-packed
    if customer_flags.size() > 0:
        customer_flags[0] = customer_flags[0] & 0xFE;


func _pack_customers() -> void:
    pass;

func _process(_delta: float) -> void:
    pass;

func customer_offset(customer: Customer) -> float:
    return motion_path.curve.get_closest_offset(to_local(customer.global_position));