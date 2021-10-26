extends Control

var _item
var is_mouse_hold = false
var tile_size = 64

var player = null

func _ready():
    if get_node("/root/Node/Player"):
        player = get_node("/root/Node/Player")

func set_item(item):
    _item = item

func get_drag_data(_position):
    if $Position2D.global_position.distance_to(player.global_position) < 1.42 * tile_size:
        return [_item.id, _item]
    else:
        return false

func _on_DragHelper_mouse_exited():
    if !is_mouse_hold:
        queue_free()

func _input(event):
    if event.is_action_pressed("ui_mouse_left") and !is_mouse_hold:
        is_mouse_hold = true
    if event.is_action_released("ui_mouse_left") and is_mouse_hold:
        is_mouse_hold = false
        if get_viewport().get_mouse_position().x < 1600 and $Position2D.global_position.distance_to(player.global_position) < 1.42 * tile_size:
            _item.global_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
        queue_free()
