extends Area2D


var player = null
var health_bar
var health

var hit_effect = preload("res://Scenes/Effects/HitEffect.tscn")

func take_damage(attack):
    var hit_effect_instance = hit_effect.instance()
    add_child(hit_effect_instance)
    hit_effect_instance.global_position = position
    health -= attack
    health_bar.set_value(health)

func _ready():
    input_pickable = true
    health = 100
    health_bar = $Node2D/VBoxContainer/ProgressBar
    health_bar.set_max(health)
    health_bar.set_value(health)
    if get_node("../Player"):
        player = get_node("../Player")

func _on_Enemy_input_event(viewport, event, shape_idx):
    if event.is_action_released("ui_right_mouse"):
        if player:
            if player.target != self:
                $TargetEffect.show()
                player.set_target(self)
            else:
                $TargetEffect.hide()
                player.set_target(null)
