class_name SprinkleAnimation extends AnimationResource

@export var sprinkle_scene: PackedScene;
@export var color: Color;
@export var pour_time: float = 0.7;

func play_animation(held_item: HeldRecipe) -> void:
    var sprinkles: GPUParticles3D = sprinkle_scene.instantiate();
    var sound_clip: AudioStreamPlayer = sprinkles.get_child(0, true);

    # Create the stream
    held_item.add_child(sprinkles);

    var material: StandardMaterial3D = sprinkles.draw_pass_1.surface_get_material(0);
    sprinkles.lifetime = pour_time;
    material.albedo_color = color;
    sprinkles.emitting = true;
    sound_clip.play();

    await sprinkles.finished
    await held_item.get_tree().create_timer(pour_time).timeout;
    if is_instance_valid(sprinkles):
        sprinkles.queue_free();