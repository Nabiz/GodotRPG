extends "res://Scripts/Enemy.gd"


func _ready():
    health = 30
    experience = 20
    damage = 8
    step_time = 0.75
    ._ready()

func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 20)
    var item1 = 224 if rng.randf() < 0.25 else 12
    var item2 = 118 if rng.randf() < 0.05 else 12
    var item3 = 96 if rng.randf() < 0.05 else 12
    var item4 = 12
    return [money, item1, item2, item3, item4]
