class_name SimpleModifier extends Node3D

@export var produces: ProductModifier;

func _on_click() -> void:
    var player_hand: PlayerHand = PlayerHand.get_active_hand();

    if player_hand.held_item is HeldRecipe:
        var held_recipe: HeldRecipe = player_hand.held_item;
        if held_recipe.add_modifier(produces):
            pass;