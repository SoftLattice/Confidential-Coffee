extends Marker3D

@export var customer_list: Array[PackedScene];

func _on_spawn_customer(order: CustomerOrder) -> void:
	print("received order ", order);