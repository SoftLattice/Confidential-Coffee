class_name CustomerStateMachine extends StateMachine

var customer: Customer:
    get:
        return get_parent() as Customer;