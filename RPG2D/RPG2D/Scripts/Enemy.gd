extends Area2D

var tile_size = 64

var player = null
var health_bar
var health


var pathfinding = null
var previous_position

var hit_effect = preload("res://Scenes/Effects/HitEffect.tscn")

var loot_scene = preload("res://Scenes/Enemies/Loot.tscn")

var reserved_area_scene = preload("res://Scenes/Utility/ReservedArea.tscn")

func _ready():
    global_position = global_position.snapped(Vector2.ONE * tile_size/2)
    previous_position = global_position
    input_pickable = true
    health = 20
    health_bar = $Node2D/VBoxContainer/ProgressBar
    health_bar.set_max(health)
    health_bar.set_value(health)
    if get_node("../Player"):
        player = get_node("../Player")
    if get_node("../Pathfinding"):
        pathfinding = get_node("../Pathfinding")

func take_damage(attack):
    var hit_effect_instance = hit_effect.instance()
    add_child(hit_effect_instance)
    hit_effect_instance.get_node("Label").text = str(attack)
    hit_effect_instance.global_position = position
    health -= attack
    health_bar.set_value(health)
    if health <= 0:
        if player:
            if player.target == self:
                $TargetEffect.hide()
                player.set_target(null)
        yield(get_tree().create_timer(0.2), "timeout")
        die()

func _on_Enemy_input_event(_viewport, event, _shape_idx):
    if event.is_action_released("ui_mouse_right"):
        if player:
            if player.target != self:
                $TargetEffect.show()
                player.set_target(self)
            else:
                $TargetEffect.hide()
                player.set_target(null)


func get_random_loot():
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var money = rng.randi_range(0, 5)
    var item1 = 189 if rng.randf() < 0.2 else 12
    var item2 = 12
    var item3 = 12
    var item4 = 12
    return [money, item1, item2, item3, item4]

func die():
    var loot = loot_scene.instance()
    loot.global_position = global_position.snapped(Vector2.ONE * tile_size/2)
    self.get_parent().add_child(loot)
    var l = get_random_loot()
    loot.set_loot(l[0], l[1], l[2], l[3], l[4])
    if reserved_area:
        reserved_area.queue_free()
    queue_free()


var path = []
var is_moving = false
var reserved_area = null

func _process(_delta):
    if path and !is_moving:
        if !is_obstacle(path[0] - global_position):
            set_animtaion(path[0] - global_position)
            
            reserved_area = reserved_area_scene.instance()
            get_parent().add_child(reserved_area)
            reserved_area.global_position = path[0]
            
            tween_move(path[0])
        path = []
    elif player:
        if global_position.distance_to(player.global_position) > 1.42 * tile_size: 
            path = pathfinding.get_path_array(global_position, player.get_free_neighbour_tile())
            if path:
                path.remove(0)
        

func tween_move(destination_position):
    previous_position = global_position
    is_moving = true
    var tween = $Tween
    $AnimatedSprite.play()
    tween.interpolate_property(self, "global_position", global_position,
    destination_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
    tween.start()

func set_animtaion(vector):
    if (Vector2.UP * tile_size).snapped(Vector2.ONE * tile_size) == vector:
        $AnimatedSprite.animation = "walk_up"
    elif (Vector2.DOWN * tile_size).snapped(Vector2.ONE * tile_size) == vector:
        $AnimatedSprite.animation = "walk_down"
    elif (Vector2.RIGHT * tile_size).snapped(Vector2.ONE * tile_size) == vector:
        $AnimatedSprite.animation = "walk_right"
    elif (Vector2.LEFT * tile_size).snapped(Vector2.ONE * tile_size) == vector:
        $AnimatedSprite.animation = "walk_left"

func _on_Tween_tween_all_completed():
    path = []
    is_moving = false
    
    $AnimatedSprite.frame = 0
    $AnimatedSprite.stop()
    
    reserved_area.queue_free()
    reserved_area = null

func is_obstacle(vector):
    $RayCast2D.cast_to = vector * 1.49
    $RayCast2D.force_raycast_update()
    return $RayCast2D.is_colliding()


func _on_Enemy_area_entered(_area):
    $Tween.remove_all()
    global_position = previous_position
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    yield(get_tree().create_timer(0.5*rng.randi_range(0, 3)), "timeout")
    is_moving = false


func _on_OverlapingArea_area_entered(_area):
    $Tween.remove_all()
    path = []
    $AnimatedSprite.frame = 0
    $AnimatedSprite.stop()
    if reserved_area:
        reserved_area.queue_free()
        reserved_area = null
    global_position = previous_position
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    yield(get_tree().create_timer(0.5*rng.randi_range(0, 3)), "timeout")
    is_moving = false
