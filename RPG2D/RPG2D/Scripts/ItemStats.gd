extends Node2D

var stats_dict = {
    "12": {"min_attack": 0, "max_attack": 0, "def": 0, "magic_def": 0}, #none
    
    "114": {"def": 2}, # helmet
    "113": {"def": 4}, # strong helmet
    
    "83": {"min_attack": 5, "max_attack": 10}, # weak sword
    "81": {"min_attack": 10, "max_attack": 20}, # medium sword
    "82": {"min_attack": 20, "max_attack": 30}, # strong sword
    
    "118": {"def": 3, "magic_def": 1}, # weak armor
    "116": {"def": 5, "magic_def": 2}, # medium armor
    "117": {"def": 10, "magic_def": 5}, # strong armor
    
    "96": {"def": 1, "magic_def": 1}, # weak shield
    "97": {"def": 3, "magic_def": 3}, # medium shield
    "98": {"def": 5, "magic_def": 5}, # strong shield
    
    "130": {"def": 1, "magic_def": 1}, # shoes
    "131": {"def": 3, "magic_def": 3}, # strong shoes
    }

func get_stats(id):
    if stats_dict.get(str(id)):
        return stats_dict.get(str(id))
    else:
        return {}
