extends Marker3D

@export var customer_list: Array[PackedScene];

func _on_spawn_customer(customer_definition: CustomerDefinition, order: CustomerOrder) -> void:
    var cafe: Cafe = Cafe.get_cafe();
    var customer: Customer = customer_definition.build_customer();

    cafe.add_child(customer);
    customer.global_transform = global_transform;
    customer.order = order;