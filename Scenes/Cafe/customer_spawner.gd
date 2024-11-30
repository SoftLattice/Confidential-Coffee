extends Marker3D

func _on_spawn_customer(customer: Customer, order: CustomerOrder) -> void:
    var cafe: Cafe = Cafe.get_cafe();
    
    if is_instance_valid(customer):
        cafe.add_child(customer);
        customer.global_transform = global_transform;
        customer.order = order;
        customer.tree_exiting.connect(Cafe.get_cafe()._on_customer_exited, CONNECT_DEFERRED);