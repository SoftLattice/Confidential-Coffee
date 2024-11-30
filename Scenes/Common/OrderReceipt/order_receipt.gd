class_name OrderReceipt extends Control

@export var landing_label: RichTextLabel;
@export var text_container: MarginContainer;
@export var primary_container: Container;
@export var font_size: int = 12;
@export var capture_viewport: SubViewport;

const VERTICAL_MARGIN: int = 4;
var displayed_lines: int = 0;
var customer: Customer;
var active_order: CustomerOrder = null;
var disposition: int = 0;

# This just pushes out a generic message for testing
func render_message(label: RichTextLabel, order: CustomerOrder) -> int:
    label.text = "";
    label.push_font_size(font_size);

    var lines_printed: int = 1;
    label.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER);
    label.append_text("***ORDER***");
    label.pop()

    for recipe in order.items:
        label.append_text("\n");
        lines_printed += recipe.print_to_label(label);

    if order.extra:
        label.append_text("\n\n");
        label.append_text(order.extra);

    label.pop();

    return lines_printed;


func prepare_display(order: CustomerOrder, pop_on_finish: bool = true) -> void:
    active_order = order;
    # Render the text into the landing display
    displayed_lines = render_message(landing_label, order);

    # Figure out the smallest (vertical_ size)
    await RenderingServer.frame_post_draw;

    landing_label.custom_minimum_size = landing_label.size;
    landing_label.reparent(text_container);

    landing_label.meta_clicked.connect(_on_meta_clicked);
    await RenderingServer.frame_post_draw;
    capture_viewport.size = primary_container.size;

    if pop_on_finish:
        pop_receipt();


func _on_meta_clicked(resource: ReceiptResource) -> void:
    resource._on_resource_select();
    render_message(landing_label, active_order);

func _exit_tree() -> void:
    active_order.clear_status();

# TODO: Juice up the receipt printing
func pop_receipt() -> void:
    var slide_tween: Tween = create_tween().bind_node(self);
    slide_tween.tween_property(self, "global_position:y", global_position.y - primary_container.size.y, 1.5);

# TODO: Juice up the receipt being torn away
func remove_receipt() -> void:
    var delivery_pad: DeliveryPad = DeliveryPad.get_delivery_pad();
    delivery_pad.clear_order();

    # Convert the receipt to an image for review
    var result_image: Image = await convert_to_image()
    # Assign a mugshot
    var mugshot: Texture = await customer.get_mugshot();
    # Record interaction
    var customer_result: CustomerResult = CustomerResult.new();
    customer_result.mugshot = mugshot;
    customer_result.receipt = ImageTexture.create_from_image(result_image);
    customer_result.disposition = disposition;
    if customer._has_uttered:
        customer_result.phrase_seed = customer.phrase_seed;
    
    CafeManager.customer_results.append(customer_result);
    queue_free();


func _on_complete_order() -> void:
    var delivery_pad: DeliveryPad = DeliveryPad.get_delivery_pad();
    var delivered_order: CustomerOrder = delivery_pad.to_order();
    disposition = active_order.compare_orders(delivered_order);
    customer.order_completed.emit.call_deferred(false);
    CafeManager.daily_income += 1;
    remove_receipt();

func _on_cancel_order() -> void:
    customer.order_completed.emit.call_deferred(true);
    disposition = -1;
    remove_receipt();

func get_receipt_size() -> Vector2:
    return text_container.size;


func convert_to_image() -> Image:
    primary_container.reparent(capture_viewport);
    primary_container.position = Vector2.ZERO;
    await RenderingServer.frame_post_draw;
    var output: Image = capture_viewport.get_texture().get_image();
    return output;