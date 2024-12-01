extends Node

@export var display_text: RichTextLabel;

func _on_back_pressed() -> void:
    SceneList.load_scene(SceneList.main_menu);

func _on_made_by_url_clicked(meta:String) -> void:
    OS.shell_open(meta);

func _on_godot_pressed() -> void:
    display_text.text = Engine.get_license_text();

func _on_fonts_license_pressed() -> void:
    display_text.text = "";
    for font_license_location in LicenseStore.font_license_locations:
        var file: FileAccess = FileAccess.open(font_license_location, FileAccess.READ);
        var content: String = file.get_as_text();
        display_text.text += content;
        display_text.text += "\n";
        file.close();

func _on_third_party_license_pressed() -> void:
    var file: FileAccess = FileAccess.open(LicenseStore.thirdp_license_location, FileAccess.READ)
    var content: String = file.get_as_text();
    display_text.text = content;
    file.close();

func _on_pcam_license_pressed() -> void:
    var file: FileAccess = FileAccess.open(LicenseStore.pcam_location, FileAccess.READ)
    var content: String = file.get_as_text();
    display_text.text = content;
    file.close();
