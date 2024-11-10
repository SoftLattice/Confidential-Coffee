class_name RecipeModifier extends ReceiptResource

@export var display_name: String;

var completed: bool = false;

func print_to_label(label: RichTextLabel, parent_completed: bool = false) -> int:
    var lines_out: int = 1;
    label.append_text(" -");
    label.push_meta(self, RichTextLabel.META_UNDERLINE_ON_HOVER);

    if parent_completed or completed:
        label.push_strikethrough();
    label.append_text("%s" % [display_name.to_upper()]);
    if parent_completed or completed:
        label.pop();

    label.pop()
    return lines_out;

func _on_resource_select() -> void:
    completed = not completed;