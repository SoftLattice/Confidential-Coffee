extends Node

signal spawn_parameters_changes();

const MAX_FLAGS_USED: int = 8;
const MAX_VERBS_USED: int = 6;

@export var verbs_used: int = 1;
@export var flags_used: int = 2;

@export var customer_list: Array[PackedScene];
@export var verb_icons: Array[Texture];
@export var country_icons: Array[Texture];
@export var phrase_probability: float = 0.5;

var spawn_data: Array[Array];

func initialize_spawn_data() -> void:
    spawn_data = [];
    for i in range(customer_list.size()):
        for j in range(flags_used):
            spawn_data.append([i,j]);
    spawn_data.shuffle();


func generate_random_customer() -> Customer:
    if spawn_data.size() < 1:
        return null;
    var spawn_details = spawn_data.pop_front();
    var customer: Customer = customer_list[spawn_details[0]].instantiate();
    customer.set_flag_index(spawn_details[1]);
    if randf() < phrase_probability:
        var phrase_seed: Array[int] = generate_random_phrase();

        if phrase_seed[1] >= spawn_details[1]:
            phrase_seed[1] += 1;

        customer.set_phrase(phrase_seed);

    return customer;

func generate_random_phrase() -> Array[int]:
    var result: Array[int];
    result.append(randi_range(0, verbs_used - 1));
    result.append(randi_range(0, flags_used - 2));
    return result

func get_phrase_icons(index: Array[int]) -> Array[Texture]:
    var result: Array[Texture];
    result.append(verb_icons[index[0]])
    result.append(country_icons[index[1]]);
    return result;


func remaining_customers() -> int:
    return spawn_data.size();


func expand_flags(count: int) -> void:
    flags_used = clampi(flags_used + count, 0, MAX_FLAGS_USED);
    spawn_parameters_changes.emit.call_deferred();


func expand_verbs(count: int) -> void:
    verbs_used = clampi(verbs_used + count, 0, MAX_VERBS_USED);
    spawn_parameters_changes.emit.call_deferred();