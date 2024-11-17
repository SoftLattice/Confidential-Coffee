class_name Order extends ReceiptResource

@export var product: Product;
@export var modifiers: Array[ProductModifier];

func print_to_label(label: RichTextLabel) -> int:
    var lines_out = 0;
    lines_out += product.print_to_label(label);
    for modifier in modifiers:
        label.append_text("\n");
        lines_out += modifier.print_to_label(label);
    return lines_out;

func can_mix_product(addition: Product) -> Product:
    if product == null:
        return addition;
    return RecipeManager.mix_recipes(product, addition);

func can_modify_product(addition: ProductModifier) -> bool:
    if product == null:
        return false;
    return addition in product.allowed_modifiers;


const SAME_ORDER: int = 0;
const DIFFERENT_MODIFIERS: int = 1;
const DIFFERENT_ORDER: int = -1;
func compare_order(other: Order) -> int:
    if other.product == product:
        if modifiers.all(func(m: ProductModifier) -> bool: return other.modifiers.has(m)):
            if other.modifiers.all(func(m: ProductModifier) -> bool: return modifiers.has(m)):
                return 0;
        return 1;
    return -1;