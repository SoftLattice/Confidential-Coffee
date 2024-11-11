class_name CustomerState extends State

var customer: Customer:
    get:
        return (machine as CustomerStateMachine).customer;