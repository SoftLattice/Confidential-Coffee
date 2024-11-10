class_name Recipe extends ReceiptResource

@export var display_name: String;
@export var modifiers: Array[RecipeModifier];

var completed: bool = false;
func print_to_label(label: RichTextLabel) -> int:
    var lines_out: int = 1;
    label.push_meta(self, RichTextLabel.META_UNDERLINE_ON_HOVER);

    if completed:
        label.push_strikethrough();
    label.append_text("%s" % [display_name.to_upper()]);
    if completed:
        label.pop();
    label.pop()

    for modifier in modifiers:
        label.append_text("\n");
        lines_out += modifier.print_to_label(label, completed);

    return lines_out;

func _on_resource_select() -> void:
    completed = not completed;