class_name PlayerHand extends Marker3D

signal hold_item();
signal release_item();

@export_category("Holdable Models")
@export var paper_cup_scene: PackedScene;

var held_item: Node3D = null;

func _on_take_cup() -> void:
    if held_item == null:
        var paper_cup = paper_cup_scene.instantiate();
        add_child(paper_cup);
        held_item = paper_cup;
        hold_item.emit.call_deferred();
        print("Took a cup!");