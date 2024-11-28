extends Node

@export var customer_results: Array[CustomerResult];

@export_category("Market Properties")
@export var deposits: int = 100;
@export var daily_expenses: int = 75;
@export var funds: int = 200;
@export var rating: float = 0.6;

@export var available_store_purchases: Array[StorePurchase];
@export var owned_store_purchases: Array[StorePurchase];

@export_category("Difficulty")
@export var max_order_size: int = 4;
@export var max_modifier_count: int = 2;

@export_category("Recipes")
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
        for i in range(mini(modifiers.size(), randi_range(0,max_modifier_count))):
            result.modifiers.append(modifiers.pop_front());
    
    return result;

func generate_random_customer_order() -> CustomerOrder:
    var result: CustomerOrder = CustomerOrder.new();
    for i in range(randi_range(1,max_order_size)):
        result.items.append(generate_random_order());
    return result;