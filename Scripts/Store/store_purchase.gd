class_name StorePurchase extends Resource

@export var title: String;
@export var price: int;
@export var daily_cost: int;

@export var enabled_products: Array[Product];
@export var enabled_modifiers: Array[ProductModifier];

@export var unlock_flags: int = 0;
@export var unlock_verbs: int = 0;

@export var enables_purchase: StorePurchase;

func action_purchase() -> void:
    # Move this from available to owned
    CafeManager.available_store_purchases.erase(self);
    CafeManager.owned_store_purchases.append(self);

    # Accumulate the daily costs
    CafeManager.daily_expenses += daily_cost;

    # Activate the items in the manager
    CafeManager.product_list.append_array(enabled_products);
    CafeManager.modifier_list.append_array(enabled_modifiers);

    CustomerManager.expand_flags.call_deferred(unlock_flags);
    CustomerManager.expand_verbs.call_deferred(unlock_verbs);

    # Add any new purchases unlocked by this one
    CafeManager.available_store_purchases.append.call_deferred(enables_purchase);