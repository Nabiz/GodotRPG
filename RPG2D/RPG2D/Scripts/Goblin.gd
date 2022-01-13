extends "res://Scripts/Enemy.gd"

func _ready():
    health = 50
    experience = 40
    damage = 15
    step_time = 0.5
    ._ready()

func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 50)
    var item1 = 240 if rng.randf() < 0.2 else 12
    var item2 = 81 if rng.randf() < 0.05 else 12
    var item3 = 97 if rng.randf() < 0.05 else 12
    var item4 = 12
    return [money, item1, item2, item3, item4]
