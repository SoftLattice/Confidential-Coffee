class_name CustomerDefinition extends Resource

@export var customer_scene: PackedScene;

func build_customer() -> Customer:
    return customer_scene.instantiate();