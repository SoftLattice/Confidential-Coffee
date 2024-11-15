extends Node3D

@onready var liquid_material: ShaderMaterial = (%Liquid as MeshInstance3D).mesh.surface_get_material(0);

func set_liquid_level(f: float) -> void:
	liquid_material.set_shader_parameter("liquid_fraction", f);

func set_liquid_color(color: Color) -> void:
	liquid_material.set_shader_parameter("liquid_color", color);