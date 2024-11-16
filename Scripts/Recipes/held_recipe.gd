class_name HeldRecipe extends Node3D

signal picked_up();
signal put_down();

@export var contents: Order;

# Try to take the item from the mat
func _on_clicked() -> void:
    if PlayerHand.get_active_hand().take_item(self):
        picked_up.emit.call_deferred();