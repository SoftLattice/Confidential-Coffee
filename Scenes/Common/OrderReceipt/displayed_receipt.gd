extends Control

@export var receipt: OrderReceipt;
@export var viewport: SubViewport;
@export var texture_rect: TextureRect;

@export var debug_order: CustomerOrder;

func _ready() -> void:
    render_receipt(debug_order);

func render_receipt(order: CustomerOrder) -> void:
    await receipt.prepare_display(debug_order, false);
    viewport.size = receipt.get_receipt_size();
    await RenderingServer.frame_post_draw;
    texture_rect.texture = ImageTexture.create_from_image(viewport.get_texture().get_image());
    viewport.queue_free();
