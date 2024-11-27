class_name ItemsArea extends Control

@export var receipt_spawn_location: Node2D;
@export var mugshot_spawn_location: Node2D;
@export var call_receipt_scene: PackedScene;
@export var customer_picture_scene: PackedScene;
@export var receipt_jitter_position: float = 3;

var call_receipts: Array[CallReceipt];

func _on_receipt_drag(call_receipt: CallReceipt) -> void:
    var index: int = call_receipts.find(call_receipt);
    call_receipts.remove_at(index);
    call_receipts.append(call_receipt);

    for i: int in range(call_receipts.size()):
        call_receipts[i].z_index = i+1;

func spawn_receipt(customer_result: CustomerResult) -> void:
    var texture: Texture = customer_result.receipt;
    var call_receipt: CallReceipt = call_receipt_scene.instantiate();
    add_child(call_receipt);
    call_receipt.customer_result = customer_result;
    call_receipt.global_position = receipt_spawn_location.global_position;
    call_receipt.texture_rect.texture = texture;
    call_receipts.append(call_receipt);
    call_receipt.drag_start.connect(_on_receipt_drag.bind(call_receipt));
    call_receipt.global_position += Vector2(
            randf_range(-receipt_jitter_position,receipt_jitter_position),
            randf_range(-receipt_jitter_position,receipt_jitter_position)
        );

    var handler_call: HandlerCall = HandlerCall.get_active_handler();
    call_receipt.send_picture.connect(handler_call._on_receipt_picture.bind(customer_result));
    handler_call.request_picture.connect(call_receipt._on_request_picture);
    handler_call.stop_picture.connect(call_receipt._on_stop_picture);
    

func spawn_customer_picture(customer_result: CustomerResult) -> CustomerPicture:
    var customer_picture: CustomerPicture = customer_picture_scene.instantiate();
    add_child(customer_picture);
    customer_picture.set_texture(customer_result.mugshot);
    customer_picture.slide_to(mugshot_spawn_location.global_position);
    return customer_picture;