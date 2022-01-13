extends "res://Scripts/RangedEnemy.gd"

func _ready():
    attack_effect = preload("res://Scenes/Effects/FireballEffect.tscn")
    health = 80
    experience = 80
    damage = 25
    step_time = 0.5
    ._ready()

func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 100)
    var item1 = 308 if rng.randf() < 0.2 else 12
    var item2 = 131 if rng.randf() < 0.05 else 12
    var item3 = 117 if rng.randf() < 0.03 else 12
    var item4 = 12
    return [money, item1, item2, item3, item4]
