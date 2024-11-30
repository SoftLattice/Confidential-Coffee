extends Node3D

@export var steam: GPUParticles3D;
@export var cooldown: Timer;

@export var cooldown_time: float = 20;

@export var produces: Product;

var _is_hot: bool = false;

func _on_steam() -> void:
    _is_hot = true;
    steam.emitting = true;
    cooldown.stop();
    cooldown.start(cooldown_time);

func _on_cooldown() -> void:
    _is_hot = false;
    steam.emitting = false;

var _is_busy: bool = false;
func _on_click() -> void:
    if !_is_hot:
        return;

    if _is_busy:
        return;

    var player_hand: PlayerHand = PlayerHand.get_active_hand();
    if player_hand.held_item is LiquidContainer:
        var container: LiquidContainer = player_hand.held_item;
        if container.add_pourable(produces):
            pass;
