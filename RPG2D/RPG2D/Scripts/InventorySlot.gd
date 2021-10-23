extends Panel

var is_mouse_hold = false
var item_scene = preload("res://Scenes/Items/Item.tscn")
var tile_size = 64
var null_id = 12

func _on_InventorySlot_gui_input(event):
    if event.is_action_pressed("ui_left_mouse"):
        if $Item.id != null_id:
            is_mouse_hold = true

func _input(event):
    if is_mouse_hold and event.is_action_released("ui_left_mouse"):
        is_mouse_hold = false
        var new_item = item_scene.instance()
        new_item.set_id($Item.id)
        get_tree().root.get_child(0).add_child(new_item)
        new_item.position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
        new_item.is_recently_draged = true
        yield(get_tree().create_timer(0.1), "timeout")
        new_item.is_recently_draged = false
        $Item.set_id(null_id)

func _on_Item_area_entered(area):
    if area.is_recently_draged and $Item.id == null_id:
        area.is_recently_draged = false
        $Item.set_id(area.id)
        yield(get_tree().create_timer(0.1), "timeout")
        area.queue_free()
