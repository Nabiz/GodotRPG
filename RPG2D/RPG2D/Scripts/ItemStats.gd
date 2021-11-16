extends Node2D

var stats_dict = {
    "12": {"min_attack": 0, "max_attack": 0, "def": 0, "magic_def": 0},
    "116": {"def": 2},
    }

func get_stats(id):
    return stats_dict[str(id)]
