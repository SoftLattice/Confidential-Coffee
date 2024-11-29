class_name Cafe extends Node

@export var day_intro: RichTextLabel;
@export var mark_primary: Node3D;
@export var receipt_scene: PackedScene;
@onready var cafe_hud: CafeHUD = get_node("%CafeHUD");
@export var customer_spawn_timer: Timer;
@export var options_scene: PackedScene;

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

    # Initial spawn is quick
    customer_spawn_timer.start(0.5 * CafeManager.spawn_interval);

    # Future spawns less frequent
    customer_spawn_timer.wait_time = CafeManager.spawn_interval;

    var purchase_nodes: Array[PurchaseRequired];
    purchase_nodes.assign(get_tree().get_nodes_in_group("purchase_required"));

    for purchase_node in purchase_nodes:
        purchase_node.audit_purchase();

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        _on_customer_spawn_timer();

    if Input.is_action_just_pressed("ui_cancel"):
        var options: Node = options_scene.instantiate();
        add_child(options);
        options.tree_exiting.connect(func() -> void: get_tree().paused = false, CONNECT_ONE_SHOT);
        get_tree().paused = true;

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

var _day_over: bool = false;
func _on_day_finished() -> void:
    if _day_over:
        return;
        
    _day_over = true;
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


func _on_customer_exited() -> void:
    if _day_over:
        return;
    if (CustomerManager.remaining_customers() == 0) and (get_tree().get_nodes_in_group("customer").size() == 0):
        _on_day_finished();