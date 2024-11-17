class_name HeldRecipe extends Node3D

signal picked_up();
signal put_down();

@export var contents: Order;

# Try to take the item from the mat
func _on_clicked() -> void:
    if PlayerHand.get_active_hand().take_item(self):
        picked_up.emit.call_deferred();


func add_modifier(modifier: ProductModifier) -> bool:
    if contents.can_modify_product(modifier):
        if contents.modifiers.has(modifier):
            return false;
        contents.modifiers.append(modifier);
        modifier.animate_addition(self);
        return true;

    return false;