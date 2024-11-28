extends MarginContainer

@export var funds_label: Label;
@export var expenses_label: Label;

@export var deposit_label: Label;
@export var deposit_container: Control;

@export var purchases_label: Label;
@export var purchases_container: Control;

var _running_purchases: int = 0;
func _on_purchase(price: int) -> void:
    _running_purchases += price;
    purchases_label.text = "$%d" % [_running_purchases];
    purchases_container.visible = true;

func _on_funds_change(value:int) -> void:
    funds_label.text = "$%d" % [value];

func _on_daily_expenses(value:int) -> void:
    expenses_label.text = "$%d" % [value];

func _on_deposit(value: int) -> void:
    deposit_label.text = "$%d" % [value];
    deposit_container.visible = true;
