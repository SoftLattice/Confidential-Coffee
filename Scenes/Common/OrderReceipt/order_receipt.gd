class_name OrderReceipt extends Control

@export var landing_label: RichTextLabel;
@export var text_container: MarginContainer;
@export var primary_container: Container;

const VERTICAL_MARGIN: int = 4;
var displayed_lines: int = 0;
var customer: Customer;
var active_order: CustomerOrder = null;

# This just pushes out a generic message for testing
func render_message(label: RichTextLabel, order: CustomerOrder) -> int:
    label.text = "";
    label.push_font_size(12);

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

    #TODO: Print TIME of day????
    return lines_printed;

func prepare_display(order: CustomerOrder) -> void:
    active_order = order;
    # Render the text into the landing display
    displayed_lines = render_message(landing_label, order);

    # Figure out the smallest (vertical_ size)
    await RenderingServer.frame_post_draw;

    landing_label.custom_minimum_size = landing_label.size;
    landing_label.get_parent().remove_child(landing_label);
    text_container.add_child(landing_label);

    landing_label.meta_clicked.connect(_on_meta_clicked);
    await RenderingServer.frame_post_draw;
    pop_receipt();


func _on_meta_clicked(resource: ReceiptResource) -> void:
    resource._on_resource_select();
    render_message(landing_label, active_order);


# TODO: Juice up the receipt printing
func pop_receipt() -> void:
    var slide_tween: Tween = create_tween().bind_node(self);
    slide_tween.tween_property(self, "global_position:y", global_position.y - primary_container.size.y, 1.5);

# TODO: Juice up the receipt being torn away
func remove_receipt() -> void:
    var delivery_pad: DeliveryPad = DeliveryPad.get_delivery_pad();
    delivery_pad.clear_order();
    queue_free();


func _on_complete_order() -> void:
    var delivery_pad: DeliveryPad = DeliveryPad.get_delivery_pad();
    var delivered_order: CustomerOrder = delivery_pad.to_order();
    print(active_order.compare_orders(delivered_order));

    delivery_pad.clear_order();

    customer.order_completed.emit.call_deferred(false);
    
    remove_receipt();

func _on_cancel_order() -> void:
    customer.order_completed.emit.call_deferred(true);
    remove_receipt();