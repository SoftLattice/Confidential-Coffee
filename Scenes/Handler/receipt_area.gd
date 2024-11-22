extends Control

@export var order_receipt_scene: PackedScene;
@export var spawn_location: Node2D;

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("debug"):
        pass;

func generate_receipt(customer_order: CustomerOrder) -> void:
    var receipt: OrderReceipt = order_receipt_scene.instantiate();
    add_child(receipt);
    await receipt.prepare_display(customer_order);
    receipt.global_position = spawn_location.global_position;