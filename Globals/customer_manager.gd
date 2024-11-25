extends Node

@export var customer_list: Array[PackedScene];
var spawn_data: Array[Array];

func initialize_spawn_data() -> void:
    spawn_data = [];
    for i in range(customer_list.size()):
        for j in range(8):
            spawn_data.append([i,j]);
    spawn_data.shuffle();

func generate_random_customer() -> Customer:
    if spawn_data.size() < 1:
        return null;
    var spawn_details = spawn_data.pop_front();
    var customer: Customer = customer_list[spawn_details[0]].instantiate();
    customer.set_flag_index(spawn_details[1]);
    return customer;