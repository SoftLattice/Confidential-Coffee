class_name Cafe extends Node

@export var day_intro: RichTextLabel;
@export var pcam_main: PhantomCamera3D;

# Singleton pattern
static var _active_cafe: Cafe;
static func get_cafe() -> Cafe:
    return _active_cafe;


func _ready() -> void:
    _active_cafe = self;
    pcam_main = get_node("%PCamMainView");

@export var mark_primary: Node3D;
@export var mark_coffee: Node3D;

@export var receipt_scene: PackedScene;

@onready var cafe_hud: CafeHUD = get_node("%CafeHUD");

@export var debug_order: CustomerOrder;
@export var debug_customer_definition: CustomerDefinition;

signal spawn_customer(customer_definition: CustomerDefinition, order: CustomerOrder);

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        spawn_customer.emit.call_deferred(debug_customer_definition, debug_order);

func _on_order_placed(order: CustomerOrder, customer: Customer) -> void:
    var order_receipt: OrderReceipt = receipt_scene.instantiate();
    cafe_hud.add_child(order_receipt);
    order_receipt.customer = customer;

    # Connect the keys to the order receipt
    cafe_hud.sell_key.pressed.connect(order_receipt._on_complete_order, CONNECT_ONE_SHOT);
    cafe_hud.cancel_key.pressed.connect(order_receipt._on_cancel_order, CONNECT_ONE_SHOT);

    order_receipt.prepare_display.call_deferred(order);
