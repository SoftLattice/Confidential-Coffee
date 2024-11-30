extends HBoxContainer

@export var price: int;
@export var price_label: Label;

@export var buy_button: Button;

signal flee_country();

func _ready() -> void:
    price_label.text = "$%d" % [ price ];

func _on_buy_button_pressed() -> void:
    flee_country.emit.call_deferred();
    buy_button.disabled = true;
    queue_free();

func _on_funds_change(funds: int) -> void:
    buy_button.disabled = funds < price;
