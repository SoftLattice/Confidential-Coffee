extends ClickableAsset

@export var target_carafe: Carafe;
@export var visual: Node3D;
@export var grounds_particles: GPUParticles3D;
@export var drip_particles: GPUParticles3D;
@export var sound: AudioStreamPlayer;

var _is_busy: bool = false;
func _on_click() -> void:
    if !_is_busy and !is_equal_approx(target_carafe.cups, target_carafe.max_cups):
        animate_refill();

func _on_carafe_filled() -> void:
    drip_particles.emitting = false;

func animate_refill() -> void:
    _is_busy = true;
    var animate_tween: Tween = create_tween();
    animate_tween.bind_node(self).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC);
    animate_tween.tween_property(visual, "position:x", 0.45, 0.75);
    animate_tween.tween_property(grounds_particles, "emitting", true, 0);
    animate_tween.tween_callback(sound.play);
    animate_tween.tween_interval(grounds_particles.lifetime);
    animate_tween.tween_property(visual, "position:x", 0., 0.75);
    animate_tween.tween_property(drip_particles, "emitting", true, 0);
    animate_tween.tween_interval(0.6);
    animate_tween.tween_callback(target_carafe.begin_filling);
    animate_tween.tween_property(self, "_is_busy", false, 0);