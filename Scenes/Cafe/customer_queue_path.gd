class_name CustomerPath extends Path3D

@export var queue_front: Node3D;
@export var counter: Node3D;
@export var exit: Node3D;

var queue_front_offset: float;
var counter_offset: float;

@export var customer_queue: Array[Customer];
@export var ordering_customer: Customer;

signal customer_dequeued();
signal customer_order_placed(order: CustomerOrder, customer: Customer);

func _ready() -> void:
    queue_front_offset = curve.get_closest_offset(queue_front.position);
    counter_offset = curve.get_closest_offset(counter.position);

func _on_new_customer(customer: Customer) -> void:
    customer_queue.push_back(customer);
    customer.at_queue_front.connect(_on_customer_at_queue_front.bind(customer), CONNECT_ONE_SHOT);
    customer.place_order.connect(_on_customer_place_order.bind(customer), CONNECT_ONE_SHOT);

func get_queue_position(customer: Customer) -> int:
    return customer_queue.find(customer);

func get_closest_offset_from_global(global_pos: Vector3) -> float:
    var local_pos: Vector3 = to_local(global_pos);
    return curve.get_closest_offset(local_pos);

func get_global_position_from_offset(offset: float) -> Vector3:
    return to_global(curve.sample_baked(offset));

func _on_customer_at_queue_front(customer: Customer) -> void:
    if ordering_customer == null:
        customer_queue.erase(customer);
        customer_dequeued.emit.call_deferred();
        customer.approach_counter.emit.call_deferred();
        ordering_customer = customer;
        ordering_customer.order_completed.connect(_on_customer_order_completed, CONNECT_ONE_SHOT);

func _on_customer_place_order(order: CustomerOrder, customer: Customer) -> void:
    if customer == ordering_customer:
        customer_order_placed.emit.call_deferred(order, customer);

func _on_customer_order_completed(_canceled: bool) -> void:
    ordering_customer = null;
    if customer_queue.size() > 0:
        var next_customer: Customer = customer_queue[0];
        if next_customer.is_customer_ready():
            _on_customer_at_queue_front.call_deferred(next_customer);