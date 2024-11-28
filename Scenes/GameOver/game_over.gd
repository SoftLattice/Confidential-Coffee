extends Node

@export var fade_in_rect: ColorRect;
@export var folder: MeshInstance3D;

@export var bankruptcy_viewport: SubViewport;
@export var warrant_viewport: SubViewport;

@export var jail_rect: ColorRect;

@export var bankruptcy: bool = true;

func _ready() -> void:
    var folder_view: StandardMaterial3D = folder.mesh.surface_get_material(1);

    if bankruptcy:
        folder_view.albedo_texture = bankruptcy_viewport.get_texture();
    else:
        folder_view.albedo_texture = warrant_viewport.get_texture();
        jail_rect.global_position = Vector2(0,-jail_rect.size.y);
        jail_rect.visible = true;

    var fade_tween: Tween = create_tween();
    fade_tween.bind_node(self);
    fade_tween.tween_property(fade_in_rect,"color:a",0.,2.);
    fade_tween.tween_callback(fade_in_rect.queue_free);

    if !bankruptcy:
        fade_tween.tween_property(jail_rect,"global_position:y",0,1.5);

func _on_main_menu_pressed() -> void:
    SceneList.load_scene(SceneList.main_menu);
