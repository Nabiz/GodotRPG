extends Node2D

var stats_dict = {
    "12": {"min_attack": 0, "max_attack": 0, "def": 0, "magic_def": 0}, #none
    
    "114": {"def": 1}, # helmet
    "113": {"def": 2}, # strong helmet
    
    "83": {"min_attack": 1, "max_attack": 10}, # weak sword
    "81": {"min_attack": 1, "max_attack": 20}, # medium sword
    "82": {"min_attack": 1, "max_attack": 30}, # strong sword
    
    "118": {"def": 2, "magic_def": 0}, # weak armor
    "116": {"def": 3, "magic_def": 0}, # medium armor
    "117": {"def": 5, "magic_def": 0}, # strong armor
    
    "96": {"def": 1, "magic_def": 0}, # weak shield
    "97": {"def": 2, "magic_def": 0}, # medium shield
    "98": {"def": 3, "magic_def": 0}, # strong shield
    
    "130": {"def": 1, "magic_def": 0}, # shoes
    "131": {"def": 2, "magic_def": 0}, # strong shoes
    }

func get_stats(id):
    if stats_dict.get(str(id)):
        return stats_dict.get(str(id))
    else:
        return {}
