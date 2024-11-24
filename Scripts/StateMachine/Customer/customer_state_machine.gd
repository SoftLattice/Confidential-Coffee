class_name CustomerStateMachine extends StateMachine

var customer: Customer:
    get:
        return get_parent() as Customer;

func _on_immediate_exit() -> void:
    _set_state("exiting");
