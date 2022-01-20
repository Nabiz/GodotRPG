extends "res://Scripts/Enemy.gd"

var attack_range = 7
var attack_effect = preload("res://Scenes/Effects/ArrowEffect.tscn")

func _ready():
    health = 35
    experience = 40
    damage = 15
    step_time = 0.5
    ready()

func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 50)
    var item1 = 240 if rng.randf() < 0.2 else 12
    var item2 = 113 if rng.randf() < 0.05 else 12
    var item3 = 116 if rng.randf() < 0.05 else 12
    var item4 = 12
    return [money, item1, item2, item3, item4]

func _process(_delta):
    process()

func process():
    attack()
    if path and !is_moving:
        if !is_obstacle(path[0] - global_position):
            set_animtaion(path[0] - global_position)
            
            reserved_area = reserved_area_scene.instance()
            get_parent().add_child(reserved_area)
            reserved_area.global_position = path[0]
            
            tween_move(path[0])
        path = []
    elif player:
        if global_position.distance_to(player.global_position) > attack_range * tile_size: 
            path = pathfinding.get_path_array(global_position, player.get_free_neighbour_tile())
            if path:
                path.remove(0)
func attack():
    if player:
        if global_position.distance_to(player.global_position) < 1.01 * tile_size * attack_range:
            if can_attack:
                create_attack_effect()
                can_attack = false
                var rng = RandomNumberGenerator.new()
                rng.randomize()
                player.take_damage(rng.randi_range(1, damage))
                $Timer.start()

func create_attack_effect():
    var attack_effect_instance = attack_effect.instance()
    attack_effect_instance.global_position = global_position
    get_parent().add_child(attack_effect_instance)
    attack_effect_instance.start_tween(player.global_position)
