class_name LiquidPourAnimation extends AnimationResource

@export var pour_stream_scene: PackedScene;
@export var color: Color;
@export var pour_time: float = 0.7;

func play_animation(held_item: HeldRecipe) -> void:
    var pour_stream: GPUParticles3D = pour_stream_scene.instantiate();
    var sound_clip: AudioStreamPlayer = pour_stream.get_child(0, true);

    # Create the stream
    held_item.add_child(pour_stream);

    var material: StandardMaterial3D = pour_stream.draw_pass_1.surface_get_material(0);
    pour_stream.lifetime = pour_time;
    material.albedo_color = color;
    pour_stream.emitting = true;
    sound_clip.play();

    await pour_stream.finished
    await held_item.get_tree().create_timer(pour_time).timeout;
    if is_instance_valid(pour_stream):
        pour_stream.queue_free();