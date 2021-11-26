extends Area2D

var tile_size = 64

var player = null
var health_bar
var health

var pathfinding = null

var hit_effect = preload("res://Scenes/Effects/HitEffect.tscn")

var loot_scene = preload("res://Scenes/Enemies/Loot.tscn")

func _ready():
    position = position.snapped(Vector2.ONE * tile_size/2)
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
                $TargetEffect.show()
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
    var item1 = 189 if rng.randf() < 0.25 else 12
    var item2 = 190 if rng.randf() < 0.25 else 12
    var item3 = 191 if rng.randf() < 0.25 else 12
    var item4 = 224 if rng.randf() < 0.2 else 12
    return [money, item1, item2, item3, item4]

func die():
    var loot = loot_scene.instance()
    loot.global_position = global_position
    self.get_parent().add_child(loot)
    var l = get_random_loot()
    loot.set_loot(l[0], l[1], l[2], l[3], l[4])
    queue_free()

var path = []
var is_moving = false
func _process(delta):
    if path and !is_moving:
        tween_move(path[0])
        path.remove(0)
    elif player:
        path = pathfinding.get_path_array(global_position, player.global_position)
        if path:
            path.remove(0)
        
func tween_move(destination_position):
    is_moving = true
    var tween = $Tween
    #$AnimatedSprite.play()
    tween.interpolate_property(self, "position", position,
    destination_position, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
    tween.start()


func _on_Tween_tween_all_completed():
    is_moving = false
