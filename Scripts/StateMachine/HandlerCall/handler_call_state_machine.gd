class_name HandlerCallStateMachine extends StateMachine;

var handler_call: HandlerCall:
    get:
        return get_parent() as HandlerCall;