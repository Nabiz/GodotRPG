extends "res://Scripts/NPC.gd"

func add_items_to_shop():
    items_dict = {224: 10, #apple
    240: 25, #meat
    308: 60, #health_potion
    229: 10, #grapes
    259: 25, #fish
    309: 60} #mana_potion
    shop.set_items(items_dict)
