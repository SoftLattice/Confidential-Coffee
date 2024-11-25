class_name Cafe extends Node

@export var day_intro: RichTextLabel;

@export var mark_primary: Node3D;

@export var receipt_scene: PackedScene;

@onready var cafe_hud: CafeHUD = get_node("%CafeHUD");

@export var customer_spawn_timer: Timer;

signal spawn_customer(customer: Customer, order: CustomerOrder);
signal start_day();
signal end_day();

# Singleton pattern
static var _active_cafe: Cafe;
static func get_cafe() -> Cafe:
    return _active_cafe;

func _ready() -> void:
    _active_cafe = self;
    CustomerManager.initialize_spawn_data();
    customer_spawn_timer.start();

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        _on_customer_spawn_timer();

func _on_order_placed(order: CustomerOrder, customer: Customer) -> void:
    var order_receipt: OrderReceipt = receipt_scene.instantiate();
    cafe_hud.add_child(order_receipt);
    order_receipt.customer = customer;

    # Connect the keys to the order receipt
    cafe_hud.sell_key.pressed.connect(order_receipt._on_complete_order, CONNECT_ONE_SHOT);
    cafe_hud.cancel_key.pressed.connect(order_receipt._on_cancel_order, CONNECT_ONE_SHOT);

    order.extra = cafe_hud.get_time();
    order_receipt.prepare_display.call_deferred(order);

func _on_preamble_finished() -> void:
    start_day.emit.call_deferred();

func _on_day_finished() -> void:
    # Send everyone home
    var customers: Array[Customer];
    customers.assign(get_tree().get_nodes_in_group("customer"));
    for customer in customers:
        customer.force_exit.call_deferred();

    await get_tree().create_timer(3.).timeout;
    end_day.emit.call_deferred();


func _on_customer_spawn_timer() -> void:
    var customer_order: CustomerOrder = CafeManager.generate_random_customer_order();
    var customer: Customer = CustomerManager.generate_random_customer();
    spawn_customer.emit.call_deferred(customer, customer_order);
