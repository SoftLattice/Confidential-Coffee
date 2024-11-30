class_name HeldRecipe extends Node3D

signal picked_up();
signal put_down();

@export var contents: Order;

var _can_take: bool = true;
# Try to take the item from the mat
func _on_clicked() -> void:
    if _can_take:
        if PlayerHand.get_active_hand().take_item(self):
            picked_up.emit.call_deferred();

func _process(delta: float) -> void:
    contents._update(delta);

func _ready() -> void:
    contents.set_held_recipe(self);

func set_product(recipe: Recipe = null) -> void:
    contents.set_product(recipe);

func can_modify_product(modifier: ProductModifier) -> bool:
    return contents.can_modify_product(modifier);

func can_mix_product(product: Product) -> Recipe:
    return contents.can_mix_product(product);

func add_modifier(modifier: ProductModifier) -> bool:
    return contents.add_modifier(modifier);

func add_sprinkles(_color: Color) -> void:
    printerr("Method 'add_sprinkles' not implemented");