class_name BasicPoured extends PouredProduct

@export var color: Color;

func animate_addition(liquid_container: LiquidContainer) -> void:
    liquid_container.fill_liquid(color);