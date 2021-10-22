extends Panel

var is_mouse_hold = false
var item_scene = preload("res://Scenes/Items/Item.tscn")
var tile_size = 64

func _on_InventorySlot_gui_input(event):
    if event.is_action_pressed("ui_left_mouse"):
        is_mouse_hold = true

func _input(event):
    if is_mouse_hold and event.is_action_released("ui_left_mouse"):
        is_mouse_hold = false
        var new_item = item_scene.instance()
        new_item.set_id($Item.id)
        new_item.position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
        get_tree().root.get_child(0).add_child(new_item)
        $Item.set_id(0)
