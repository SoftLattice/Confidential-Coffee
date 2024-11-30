class_name Product extends ReceiptResource

@export var display_name: String;
@export var allowed_modifiers: Array[ProductModifier];

func clear_status() -> void:
    completed = false;

var completed: bool = false;
func print_to_label(label: RichTextLabel) -> int:
    label.append_text("%s" % [display_name.to_upper()]);
    return 1;

func _on_resource_select() -> void:
    completed = not completed;

func _enter_resource(_order: Order, _recipe: Recipe = null) -> void:
    pass;

func _exit_resource(_order: Order) -> void:
    pass;