extends Node3D

@export var water_duration: float = 1.5;
@export var foam_delay: float = 0.2;

@export var water_effect: GPUParticles3D;
@export var foam_effect: GPUParticles3D;

@export var sound: AudioStreamPlayer;

func _on_click() -> void:
    var player_hand: PlayerHand = PlayerHand.get_active_hand();
    if player_hand.held_item != null:
        player_hand.held_item.queue_free();
        _play_water.call_deferred();


func _play_water() -> void:
    water_effect.set_emitting(true);
    sound.play();
    get_tree().create_timer(water_duration).timeout.connect(water_effect.set_emitting.bind(false));
    await get_tree().create_timer(foam_delay).timeout;
    foam_effect.set_emitting(true);
    get_tree().create_timer(water_duration).timeout.connect(foam_effect.set_emitting.bind(false));