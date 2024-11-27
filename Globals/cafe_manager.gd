extends Node

@export var max_order_size: int = 4;
@export var customer_results: Array[CustomerResult];

@export var product_list: Array[Product];
@export var modifier_list: Array[ProductModifier];

func generate_random_order() -> Order:
    var result: Order = Order.new();
    result.product = product_list.pick_random();
    var modifiers: Array[ProductModifier];
    modifiers.assign(result.product.allowed_modifiers.filter(
                func(m: ProductModifier) -> bool:
                    return modifier_list.has(m))
                );

    if modifiers.size() > 0:
        modifiers.shuffle();
        for i in range(mini(modifiers.size(), randi_range(0,2))):
            result.modifiers.append(modifiers.pop_front());
    
    return result;

func generate_random_customer_order() -> CustomerOrder:
    var result: CustomerOrder = CustomerOrder.new();
    for i in range(randi_range(1,max_order_size)):
        result.items.append(generate_random_order());
    return result;