extends "res://Scripts/NPC.gd"

func add_items_to_shop():
    items_dict = {130: 20,
    131: 100}
    shop.set_items(items_dict)
