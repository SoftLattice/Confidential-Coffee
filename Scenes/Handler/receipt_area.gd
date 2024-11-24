extends Control

@export var spawn_location: Node2D;
@export var call_receipt_scene: PackedScene;

var call_receipts: Array[CallReceipt];

func _ready() -> void:
    while CafeManager.daily_receipts:
        var texture: Texture = CafeManager.daily_receipts.pop_back();
        spawn_receipt.call_deferred(texture);

func _on_receipt_drag(call_receipt: CallReceipt) -> void:
    var index: int = call_receipts.find(call_receipt);
    call_receipts.remove_at(index);
    call_receipts.append(call_receipt);

    for i: int in range(call_receipts.size()):
        call_receipts[i].z_index = i+1;

func spawn_receipt(texture: Texture) -> void:
    var call_receipt: CallReceipt = call_receipt_scene.instantiate();
    add_child(call_receipt);
    call_receipt.global_position = spawn_location.global_position;
    call_receipt.texture_rect.texture = texture;
    call_receipts.append(call_receipt);
    call_receipt.drag_start.connect(_on_receipt_drag.bind(call_receipt));