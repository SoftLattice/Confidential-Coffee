class_name StoreItem extends HBoxContainer

@export var item_title: Label;
@export var item_price: Label;
@export var buy_button: Button;

@export var purchase: StorePurchase;

signal purchase_item();

func set_purchase(in_purchase: StorePurchase) -> void:
    purchase = in_purchase;
    item_title.text = purchase.title;
    item_price.text = "$%d" % [ purchase.price];

func _on_buy_button_pressed() -> void:
    purchase_item.emit.call_deferred();
    buy_button.disabled = true;

func _on_funds_change(funds: int) -> void:
    buy_button.disabled = funds < purchase.price;
