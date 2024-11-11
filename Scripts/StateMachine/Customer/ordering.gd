extends CustomerState

var customer_path: CustomerPath;

func _enter_state() -> void:
	customer_path = customer.get_customer_path();
	customer.place_order.emit.call_deferred(customer.order);


func _on_order_completed(canceled: bool) -> void:
	if canceled:
		customer.velocity *= 2.0;
	transitioned.emit("exiting");
