class_name StateMachine extends Node

@export var initial_state: State;

var current_state: State;
var states: Dictionary = {};

func _ready() -> void:
    _initialize_machine();
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child;
            child.transitioned.connect(on_child_transition.bind(child));
            child.machine = self;
    
    if initial_state:
        initial_state._is_active_state = true;
        initial_state._enter_state.call_deferred();
        current_state = initial_state;

func _initialize_machine() -> void:
    pass;

func _process(delta: float) -> void:
    if current_state:
        current_state._update(delta);

func _physics_process(delta: float) -> void:
    if current_state:
        current_state._physics_update(delta);

func on_child_transition(new_state_name: String, state: State) -> void:
    if state != current_state:
        return;

    var new_state: State = states.get(new_state_name.to_lower());
    if !new_state:
        return;

    if current_state:
        current_state._is_active_state = false;
        current_state._exit_state();

    current_state = new_state;
    new_state._is_active_state = true;
    new_state._enter_state();
    new_state.enter_state.emit.call_deferred();

func _set_state(new_state_name: String) -> void:
    var new_state: State = states.get(new_state_name.to_lower());
    if current_state:
        current_state._is_active_state = false;
        current_state._exit_state();
    current_state = new_state;
    new_state._is_active_state = true;
    new_state._enter_state();