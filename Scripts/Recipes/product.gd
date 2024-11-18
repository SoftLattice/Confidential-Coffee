class_name Product extends ReceiptResource

@export var display_name: String;
@export var allowed_modifiers: Array[ProductModifier];

var completed: bool = false;
func print_to_label(label: RichTextLabel) -> int:
    label.push_meta(self, RichTextLabel.META_UNDERLINE_ON_HOVER);
    if completed:
        label.push_strikethrough();
    label.append_text("%s" % [display_name.to_upper()]);
    if completed:
        label.pop();
    label.pop()
    return 1;

func _on_resource_select() -> void:
    completed = not completed;

func _enter_resource(_order: Order) -> void:
    pass;

func _exit_resource(_order: Order) -> void:
    pass;