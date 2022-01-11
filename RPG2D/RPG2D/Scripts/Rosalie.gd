extends "res://Scripts/NPC.gd"

func add_items_to_shop():
    items_dict = {224: 5, #apple
    240: 15, #meat
    308: 50, #health_potion
    229: 5, #grapes
    259: 15, #fish
    309: 50} #mana_potion
    shop.set_items(items_dict)
