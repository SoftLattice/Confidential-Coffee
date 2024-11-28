extends MarginContainer

@export var store_item_container: Control;
var store_items: Array[StoreItem];

func _ready() -> void:
    store_items.assign(store_item_container.get_children());