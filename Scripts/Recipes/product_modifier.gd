class_name ProductModifier extends ReceiptResource

@export var display_name: String;

func clear_status() -> void:
    completed = false;

var completed: bool = false;
func print_to_label(label: RichTextLabel) -> int:
    var lines_out: int = 1;
    label.append_text(" -");
    label.append_text("%s" % [display_name.to_upper()]);
    return lines_out;

func _on_resource_select() -> void:
    completed = not completed;

func _enter_resource(_order: Order) -> void:
    pass;

func _exit_resource(_order: Order) -> void:
    pass;