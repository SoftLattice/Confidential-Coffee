class_name PurchaseRequired extends Node

@export var apply: bool = true;
@export var required_purchase: StorePurchase;

func audit_purchase() -> void:
    if apply and !CafeManager.owned_store_purchases.has(required_purchase):
        get_parent().queue_free();