class_name StorePurchase extends Resource

@export var title: String;
@export var price: int;

@export var enabled_products: Array[Product];
@export var enabled_modifiers: Array[ProductModifier];