extends Node2D

var consumable_stats_dict = {
    "224": {"health": 10}, #apple
    "229": {"mana": 10}, #grapes
    "240": {"health": 20}, #meat
    "259": {"mana": 20}, #fish
    "308": {"health": 50}, #health_potion
    "309": {"mana": 50} #mana_potion
    }

func get_consumable_stats(id):
    if consumable_stats_dict.get(str(id)):
        return consumable_stats_dict.get(str(id))
    else:
        return {}
