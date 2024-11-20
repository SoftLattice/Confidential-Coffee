extends Node3D

@export var produces: Product;

func _on_click() -> void:
    var player_hand: PlayerHand = PlayerHand.get_active_hand();
    if player_hand.held_item is LiquidContainer:
        var container: LiquidContainer = player_hand.held_item;
        
        var result: Recipe = container.can_mix_product(produces);
        if result == null:
            return;

        container.set_product(result);