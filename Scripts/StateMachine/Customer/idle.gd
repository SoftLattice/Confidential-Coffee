extends CustomerState

func _on_path_start() -> void:
    transitioned.emit("walking");

func _on_start_walking() -> void:
    transitioned.emit("walking");