extends "res://Scripts/Enemy.gd"

func _ready():
    health = 80
    experience = 80
    damage = 25
    step_time = 0.5
    ._ready()

func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 100)
    var item1 = 308 if rng.randf() < 0.25 else 12
    var item2 = 82 if rng.randf() < 0.05 else 12
    var item3 = 98 if rng.randf() < 0.05 else 12
    var item4 = 12
    return [money, item1, item2, item3, item4]
