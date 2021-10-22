extends Node2D

var tile_size = 64
var id = 128
var is_mouse_hold = false
var player = null

func _ready():
    $Sprite.frame = id
    position = position.snapped(Vector2.ONE * tile_size/2)
    if get_node("/root/Node/Player"):
        player = get_node("/root/Node/Player")

func set_id(new_id):
    id = new_id
    $Sprite.frame = id

func _on_Item_input_event(viewport, event, shape_idx):
    if event.is_action_pressed("ui_left_mouse"):
        is_mouse_hold = true

func _input(event):
    if is_mouse_hold and event.is_action_released("ui_left_mouse"):
        is_mouse_hold = false
        if player:
            if position.distance_to(player.position) < 1.42 * tile_size:
                var new_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size)
                position = new_position + Vector2.ONE * tile_size/2
