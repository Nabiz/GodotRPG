extends "res://Scripts/RangedEnemy.gd"

func _ready():
    attack_effect = preload("res://Scenes/Effects/FireballEffect.tscn")
    health = 80
    experience = 80
    damage = 25
    step_time = 0.5
    ._ready()
