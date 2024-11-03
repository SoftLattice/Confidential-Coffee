extends RichTextLabel


func _ready() -> void:
	var day_string: String = "Day: %s" % [SaveData.current_day];
	var time_string: String = "6:00 AM";

	text = ""
	push_paragraph(HORIZONTAL_ALIGNMENT_CENTER);
	push_font_size(96);
	append_text(day_string);
	append_text("\n");
	pop()
	push_font_size(64)
	append_text(time_string);
	pop();
	pop();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
