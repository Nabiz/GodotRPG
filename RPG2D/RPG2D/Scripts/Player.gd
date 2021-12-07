extends Area2D

var tile_size = 64
var is_moving = false
var target = null
var is_attack_cooldown = false

onready var gui = $GUINode/GUI
onready var health_bar = $BarsNode/HealthBar
onready var mana_bar = $BarsNode/ManaBar

var min_attack = 1
var max_attack = 1
var def = 0
var magic_def = 0

var max_health = 60
var max_mana = 5
var health = 60
var mana = 5

var level = 1
var experience = 0
var exp_to_next_level = 50

func _ready():
    position = position.snapped(Vector2.ONE * tile_size/2)
    
    exp_to_next_level = 50 * pow(2, level-1)

    health_bar.max_value = max_health
    mana_bar.max_value = max_mana
    health_bar.value = health
    mana_bar.value = mana
    gui.set_bars_max_value(max_health, max_mana, exp_to_next_level)
    gui.update_bars(health, mana, experience)

func gain_exp(exp_gain):
    experience += exp_gain
    if experience >= exp_to_next_level:
        experience-=exp_to_next_level
        level+=1
        gui.set_level_label(level)
        exp_to_next_level = 50 * pow(2, level-1)
        max_health+=20
        max_mana+=5
        health=max_health
        mana=max_mana
        health_bar.max_value = max_health
        mana_bar.max_value = max_mana
        health_bar.value = health
        mana_bar.value = mana
        gui.set_bars_max_value(max_health, max_mana, exp_to_next_level)
    gui.update_bars(health, mana, experience)

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

var hit_effect = preload("res://Scenes/Effects/HitEffect.tscn")

func take_damage(damage):
    var health_loss = max(0, damage - def)
    health -= health_loss
    gui.update_bars(health, mana, experience)
    health_bar.value = health
    mana_bar.value = mana
    
    if health_loss > 0:
        var hit_effect_instance = hit_effect.instance()
        add_child(hit_effect_instance)
        hit_effect_instance.get_node("Label").text = str(health_loss)
        hit_effect_instance.global_position = position


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

var health_gain = 2
var mana_gain = 1

func _on_RegenerationTimer_timeout():
    health = min(health+health_gain, max_health)
    mana = min(mana+mana_gain, max_mana)
    gui.update_bars(health, mana, experience)
    health_bar.value = health
    mana_bar.value = mana
