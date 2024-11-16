class_name DeliveryPad extends ClickableAsset

static var _active_pad: DeliveryPad;
static func get_delivery_pad() -> DeliveryPad:
    return _active_pad;

func _ready() -> void:
    _active_pad = self;

#TODO: Sort out how to squeeze all items onto the pad...
func _on_click() -> void:
    var new_item: Node3D = PlayerHand.get_active_hand().held_item;
    if new_item == null:
        return;

    if new_item is HeldRecipe:
        new_item.reparent(self, false);
        new_item.put_down.emit.call_deferred();


# Convert whatever is on the counter to a customer order
func to_order() -> CustomerOrder:
    var delivered_items: Array[HeldRecipe];
    delivered_items.assign(get_children().filter(func(t: Node) -> bool: return t is HeldRecipe));

    var customer_order: CustomerOrder = CustomerOrder.new();
    customer_order.items.assign(delivered_items.map(func(o: HeldRecipe) -> Order: return o.contents));

    return customer_order;


func clear_order() -> void:
    var delivered_items: Array[HeldRecipe];
    delivered_items.assign(get_children().filter(func(t: Node) -> bool: return t is HeldRecipe));
    for item in delivered_items:
        item.queue_free();
