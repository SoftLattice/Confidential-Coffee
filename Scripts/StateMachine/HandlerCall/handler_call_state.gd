class_name HandlerCallState extends State

var handler_call: HandlerCall:
    get:
        return (machine as HandlerCallStateMachine).handler_call;

func simple_string_render(label: RichTextLabel, words: String) -> void:
    label.text = "";
    label.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER );
    label.push_font_size(12);
    label.append_text(words);
    label.pop();
    label.pop();