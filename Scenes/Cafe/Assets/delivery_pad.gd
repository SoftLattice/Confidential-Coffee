class_name DeliveryPad extends ClickableAsset

@export var spots: Node;
var spot_list: Array[Node3D];
var spot_status: Dictionary;

static var _active_pad: DeliveryPad;
static func get_delivery_pad() -> DeliveryPad:
    return _active_pad;

func _ready() -> void:
    _active_pad = self;
    spot_list.assign(spots.get_children());
    for spot in spot_list:
        spot_status[spot] = null;

var delivered_items: Array[HeldRecipe];

#TODO: Sort out how to squeeze all items onto the pad...
func _on_click() -> void:
    var new_item: Node3D = PlayerHand.get_active_hand().held_item;
    if new_item == null:
        return;

    var new_spot: Node3D = _find_open_spot();
    # TODO: Indicate too many things are on the pad...
    if new_spot == null:
        return;

    if new_item is HeldRecipe:
        delivered_items.append(new_item);
        new_item.picked_up.connect(_on_item_removed.bind(new_item), CONNECT_ONE_SHOT);
        new_item.reparent(self);
        new_item.position = new_spot.position;
        spot_status[new_spot] = new_item;
        new_item.put_down.emit.call_deferred();

func _find_open_spot() -> Node3D:
    for spot in spot_list:
        if spot_status[spot] == null:
            return spot;
    return null;

func _on_item_removed(held_item: HeldRecipe) -> void:
    for spot in spot_list:
        if spot_status[spot] == held_item:
            spot_status[spot] = null;
            break;
    delivered_items.erase(held_item);
    print("Removed an item!");

# Convert whatever is on the counter to a customer order
func to_order() -> CustomerOrder:
    var customer_order: CustomerOrder = CustomerOrder.new();
    customer_order.items.assign(delivered_items.map(func(o: HeldRecipe) -> Order: return o.contents));

    return customer_order;


func clear_order() -> void:
    for item in delivered_items:
        item.queue_free();
