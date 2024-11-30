extends Node

@export var customer_results: Array[CustomerResult];

@export_category("Market Properties")
const INITIAL_FUNDS: int = 200;
const BASE_DAILY_EXPENSES: int = 25;

@export var deposits: int = 0;
@export var daily_expenses: int = BASE_DAILY_EXPENSES;
@export var funds: int = INITIAL_FUNDS;
@export var rating: float = 0.0;
@export var rating_count: int = 0;

@export var available_store_purchases: Array[StorePurchase];
@export var owned_store_purchases: Array[StorePurchase];

@export var daily_income: int = 0;

@export_category("Difficulty")
const SPAWN_SCALE: float = 15.;
const SPAWN_LERP: float = 0.25;

@export var max_order_size: int = 4;
@export var max_modifier_count: int = 2;
@export var spawn_interval: float = SPAWN_SCALE;

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


func rate_dispositions(dispositions: Array[int]) -> void:
    var total_dispostion: float = 0;

    for disposition in dispositions:
        total_dispostion += _disposition_to_rating(disposition);
    total_dispostion /= 5.;

    var running_disposition: float = (rating * rating_count) + total_dispostion;
    rating_count += dispositions.size();
    rating = running_disposition / float(rating_count);

    # Customers are faster when it's a better rating
    spawn_interval = lerpf(spawn_interval, SPAWN_SCALE / (rating + 1.0), SPAWN_LERP);
    

func _disposition_to_rating(disposition: int) -> float:
    # Correct order = 5*
    if disposition == CustomerOrder.CORRECT_ORDER:
        return 5.;

    # Dismissed or missing items = 1*
    if disposition == -1:
        return 1.;
    if disposition & CustomerOrder.MISSING_ITEMS != 0:
        return 1.;

    # Messed up correct items = 3*
    var result: float = 3.;
    if disposition & CustomerOrder.WRONG_MODIFIERS != 0:
        result = 3.;
        
    # Improved by extra items
    if disposition & CustomerOrder.EXTRA_ITEMS != 0:
        result += 1;

    return result;