extends Area2D

onready var loot = $Loot

var tile_size = 64
var player

func _ready():
    if get_node("../Player"):
        player = get_node("../Player")

func _process(delta):
    if loot.visible and global_position.distance_to(player.global_position) > 1.42*tile_size:
        loot.visible = false

func _input_event(_viewport, event, _shape_idx):
        if event.is_action_pressed("ui_mouse_right"):
            if loot.visible:
                loot.visible = false
            else:
                loot.visible = true
