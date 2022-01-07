extends Control

var _item
var is_mouse_hold = false
var tile_size = 64

var player = null

func set_player(new_player):
    player = new_player

func _process(_delta):
    if is_processing_input():
        check_existence()

func set_item(item):
    _item = item

func get_drag_data(_position):
    if player:
        if $Position2D.global_position.distance_to(player.global_position) < 1.42 * tile_size:
            return [_item.id, _item]
        else:
            return false

func _on_DragHelper_mouse_exited():
    if !is_mouse_hold:
        set_process_input(false)
        visible = false

func check_existence():
    if $Position2D.global_position.distance_to(get_global_mouse_position()) > 0.71 * tile_size:
        if !is_mouse_hold:
            set_process_input(false)
            visible = false

func _input(event):
    if event.is_action_pressed("ui_mouse_left") and !is_mouse_hold:
        is_mouse_hold = true
    if event.is_action_released("ui_mouse_left") and is_mouse_hold:
        is_mouse_hold = false
        if get_viewport().get_mouse_position().x < 1600 and $Position2D.global_position.distance_to(player.global_position) < 1.42 * tile_size:
            var previous_item_position = _item.global_position
            _item.global_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
            yield(get_tree().create_timer(0.1), "timeout")
            if _item.get_overlapping_areas().size() > 0:
                _item.global_position = previous_item_position
            if _item.get_overlapping_bodies().size() > 0:
                _item.global_position = previous_item_position
        set_process_input(false)
        visible = false
