extends Area2D

var tile_size = 64

var player = null
var health_bar
var health

var hit_effect = preload("res://Scenes/Effects/HitEffect.tscn")

func _ready():
    position = position.snapped(Vector2.ONE * tile_size/2)
    input_pickable = true
    health = 100
    health_bar = $Node2D/VBoxContainer/ProgressBar
    health_bar.set_max(health)
    health_bar.set_value(health)
    if get_node("../Player"):
        player = get_node("../Player")

func take_damage(attack):
    var hit_effect_instance = hit_effect.instance()
    add_child(hit_effect_instance)
    hit_effect_instance.global_position = position
    health -= attack
    health_bar.set_value(health)
    if health <= 0:
        if player:
            if player.target == self:
                $TargetEffect.show()
                player.set_target(null)
        yield(get_tree().create_timer(0.2), "timeout")
        queue_free()

func _on_Enemy_input_event(_viewport, event, _shape_idx):
    if event.is_action_released("ui_mouse_right"):
        if player:
            if player.target != self:
                $TargetEffect.show()
                player.set_target(self)
            else:
                $TargetEffect.hide()
                player.set_target(null)
