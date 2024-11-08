extends Node2D

@export var landing_label: RichTextLabel;
@export var text_container: MarginContainer;
@export var primary_container: Container;

const VERTICAL_MARGIN: int = 4;
var displayed_lines: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    prepare_display(render_message);

# This just pushes out a generic message for testing
func render_message(label: RichTextLabel) -> int:
    label.text = "";
    label.push_font_size(12);

    label.push_meta(0, RichTextLabel.META_UNDERLINE_ON_HOVER);
    label.append_text("1 COFFEE");
    label.pop();

    label.append_text("\n");

    label.push_meta(1, RichTextLabel.META_UNDERLINE_ON_HOVER);
    label.append_text("1 LATTE");
    label.append_text("\n");
    label.append_text("  + CARAMEL");
    label.pop();

    label.push_meta(2, RichTextLabel.META_UNDERLINE_ON_HOVER);
    label.append_text("\n");
    label.append_text("2 ESPRESSO");
    label.pop();

    label.pop();
    return 4


func prepare_display(render_function: Callable) -> void:
    # Render the text into the landing display
    displayed_lines = render_function.call(landing_label);

    # Figure out the smallest (vertical_ size)
    await RenderingServer.frame_post_draw;

    landing_label.custom_minimum_size = landing_label.size;
    landing_label.get_parent().remove_child(landing_label);
    text_container.add_child(landing_label);

    landing_label.meta_clicked.connect(_on_meta_clicked);
    await RenderingServer.frame_post_draw;
    pop_receipt();


func _on_meta_clicked(meta: Variant) -> void:
    print(meta);

# TODO: Juice up the receipt printing
func pop_receipt() -> void:
    var slide_tween: Tween = create_tween().bind_node(self);
    slide_tween.tween_property(self, "global_position:y", global_position.y - primary_container.size.y, 2.);
