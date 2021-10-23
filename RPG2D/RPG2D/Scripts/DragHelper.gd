extends Control

var _id
var _item
var is_mouse_hold = false
var tile_size = 64

func set_item(item):
    _item = item
    _id = item.id

func get_drag_data(_position):
    return _id

func _on_DragHelper_mouse_exited():
    if !is_mouse_hold:
        queue_free()

func _input(event):
    if event.is_action_pressed("ui_mouse_left") and !is_mouse_hold:
        is_mouse_hold = true
    if event.is_action_released("ui_mouse_left") and is_mouse_hold:
        is_mouse_hold = false
        if get_viewport().get_mouse_position().x < 1600:
            _item.global_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
        queue_free()
