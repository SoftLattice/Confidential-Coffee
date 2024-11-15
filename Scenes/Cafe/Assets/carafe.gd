extends Node3D

@export var liquid: MeshInstance3D;
@onready var liquid_shader = liquid.mesh.surface_get_material(0);

func _ready() -> void:
    print("liquid!");