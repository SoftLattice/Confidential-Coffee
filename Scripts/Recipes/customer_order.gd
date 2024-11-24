class_name CustomerOrder extends Resource

@export var items: Array[Order];
@export var extra: String;

const CORRECT_ORDER: int = 0x0;
const EXTRA_ITEMS: int = 0x1;
const WRONG_MODIFIERS: int = 0x2;
const MISSING_ITEMS: int = 0x4;

func clear_status() -> void:
    for order in items:
        order.clear_status();

func compare_orders(other_order: CustomerOrder) -> int:
    var orders: Array[Order] = items.duplicate();
    var other_orders: Array[Order] = other_order.items.duplicate();

    var flags_out: int = 0;

    var erase_at: Array[int];
    # Find all exact matches
    for i: int in range(orders.size()):
        var order: Order = orders[i];
        for other in other_orders:
            if order.compare_order(other) == Order.SAME_ORDER:
                erase_at.append(i);
                other_orders.erase(other);
                break;

    while erase_at:
        var e: int = erase_at.pop_back();
        orders.remove_at(e);

    for i: int in range(orders.size()):
        var order: Order = orders[i];
        for other in other_orders:
            if order.compare_order(other) == Order.DIFFERENT_MODIFIERS:
                flags_out |= WRONG_MODIFIERS;
                erase_at.append(i);
                other_orders.erase(other);
                break;

    while erase_at:
        var e: int = erase_at.pop_back();
        orders.remove_at(e);

    if orders.size() > 0:
        flags_out |= MISSING_ITEMS;
    
    if other_orders.size() > 0:
        flags_out |= EXTRA_ITEMS;

    return flags_out;