extends "res://Scripts/NPC.gd"

func add_items_to_shop():
    items_dict = {83: 10,
    130: 20,
    131: 150}
    shop.set_items(items_dict)
