extends CafePath

@export var active_customer: Customer;
@export var entrance_queue: CafePath;

var customer_moving: bool = false;
func _process(_delta: float) -> void:
    if customer_moving:
        var customer_position: Vector3 =  motion_path.to_local(active_customer.global_position);
        var customer_offset: float = motion_path.curve.get_closest_offset(customer_position);
        if is_equal_approx(customer_offset, motion_path.curve.get_baked_length()):
            active_customer.stop_walking.emit();
            customer_moving = false;

func _on_customer_served() -> void:
    customer_moving = false;
    active_customer.change_paths(next_path);
    active_customer = null;
    path_opened.emit.call_deferred();

func is_path_open() -> bool:
    return active_customer == null;

func _on_join_path(customer: Customer) -> void:
    active_customer = customer;
    customer_moving = true;
