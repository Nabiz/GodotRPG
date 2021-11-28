extends Area2D

var tile_size = 64
var is_moving = false
var target = null
var is_attack_cooldown = false

var gui = null

var min_attack = 1
var max_attack = 1
var def = 0
var magic_def = 0

func set_stats(new_min_attack, new_max_attack, new_def, new_magic_def):
    min_attack = new_min_attack
    max_attack = new_max_attack
    def = new_def
    magic_def = new_magic_def

func attack():
    if target and not is_attack_cooldown:
        if position.distance_to(target.position) <= 1.42 * tile_size:
            $Timer.start(2)
            is_attack_cooldown = true
            var rng = RandomNumberGenerator.new()
            rng.randomize()
            var attack_value = rng.randi_range(min_attack, max_attack)
            target.take_damage(attack_value)

func _ready():
    position = position.snapped(Vector2.ONE * tile_size/2)

func _process(_delta):
    if !is_moving:
        if Input.is_action_pressed("ui_left"):
            if !is_obstacle(Vector2.LEFT):
                $AnimatedSprite.set_animation("walk_left")
                tween_player(Vector2.LEFT)
        elif Input.is_action_pressed("ui_right"):
            if !is_obstacle(Vector2.RIGHT):
                $AnimatedSprite.set_animation("walk_right")
                tween_player(Vector2.RIGHT)
        elif Input.is_action_pressed("ui_up"):
            if !is_obstacle(Vector2.UP):
                $AnimatedSprite.set_animation("walk_up")
                tween_player(Vector2.UP)
        elif Input.is_action_pressed("ui_down"):
            if !is_obstacle(Vector2.DOWN):
                $AnimatedSprite.set_animation("walk_down")
                tween_player(Vector2.DOWN)

    attack()

func set_gui(new_gui):
    gui = new_gui

func set_target(new_target):
    if target:
        target.get_node("TargetEffect").hide()
    target = new_target

func is_obstacle(vector):
    $RayCast2D.cast_to = vector * tile_size * 1.49
    $RayCast2D.force_raycast_update()
    return $RayCast2D.is_colliding()

func get_free_neighbour_tile():
    if !is_obstacle(Vector2.UP):
        return global_position + Vector2.UP * tile_size
    if !is_obstacle(Vector2.DOWN):
        return global_position + Vector2.DOWN * tile_size
    if !is_obstacle(Vector2.RIGHT):
        return global_position + Vector2.RIGHT * tile_size
    if !is_obstacle(Vector2.LEFT):
        return global_position + Vector2.LEFT * tile_size
    else:
        return null

func tween_player(vector):
    is_moving = true
    var tween = $Tween
    $AnimatedSprite.play()
    tween.interpolate_property(self, "position", position,
    position+vector * tile_size, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
    tween.start()

func _on_Tween_tween_all_completed():
    is_moving = false
    $AnimatedSprite.stop()
    $AnimatedSprite.set_frame(0)

func _on_Timer_timeout():
    is_attack_cooldown = false
