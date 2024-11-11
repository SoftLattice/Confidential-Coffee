extends CustomerState

var exit: Node3D;

func _enter_state() -> void:
	exit = customer.get_customer_path().exit;
	customer.start_walking.emit.call_deferred();

func _update(delta: float) -> void:
	customer.global_position = customer.global_position.move_toward(
			exit.global_position, delta * customer.velocity
		);
