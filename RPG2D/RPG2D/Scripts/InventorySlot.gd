extends Panel

var is_mouse_hold = false
var item_scene = preload("res://Scenes/Items/Item.tscn")
var tile_size = 64
var null_id = 12
var id

func _ready():
    id = null_id
    $Sprite.frame = id

func can_drop_data(_position, _data):
    return id == null_id

func get_drag_data(_position):
    return [id, $Sprite]

func drop_data(_position, data):
    if data:
        id = data[0]
        var item = data[1]
        if item is Sprite:
            item.frame = null_id
            item.get_parent().id = null_id
        else:
            item.queue_free()
        $Sprite.frame = id

func _input(event):
    if event.is_action_released("ui_mouse_left") and is_mouse_hold:
        is_mouse_hold = false
        if get_viewport().get_mouse_position().x < 1600:
            var item = item_scene.instance()
            item.id = id
            get_tree().root.get_child(0).add_child(item)
            item.global_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
            id = null_id
            $Sprite.frame = id

func _on_InventorySlot_gui_input(event):
    if event.is_action_pressed("ui_mouse_left") and !is_mouse_hold:
        is_mouse_hold = true
