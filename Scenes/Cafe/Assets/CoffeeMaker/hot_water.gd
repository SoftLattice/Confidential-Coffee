extends Node3D

signal pour_water();

@export var produces: Product;

var _is_busy: bool = false;
func _on_click() -> void:
    if _is_busy:
        return;

    var player_hand: PlayerHand = PlayerHand.get_active_hand();
    if player_hand.held_item is LiquidContainer:
        var container: LiquidContainer = player_hand.held_item;
        if container.add_pourable(produces):
            pour_water.emit.call_deferred();
