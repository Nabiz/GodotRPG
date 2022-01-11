extends "res://Scripts/Enemy.gd"

var attack_range = 5
var attack_effect = preload("res://Scenes/Effects/ArrowEffect.tscn")

func _ready():
    health = 35
    experience = 40
    damage = 15
    step_time = 0.5
    ._ready()

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
