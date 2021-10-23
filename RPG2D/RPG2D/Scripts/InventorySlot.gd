extends Panel

var is_mouse_hold = false
var item_scene = preload("res://Scenes/Items/Item.tscn")
var tile_size = 64
var null_id = 12

func can_drop_data(_position, _data):
    return true

func drop_data(_position, data):
    $Sprite.frame = data
