extends Node2D

var tile_size = 64
var id = 128
var player = null

var is_recently_draged = false

var drag_helper = preload("res://Scenes/Utility/DragHelper.tscn")
var drag_helper_instance

func _ready():
    $Sprite.frame = id
    position = position.snapped(Vector2.ONE * tile_size/2)
    if get_node("/root/Node/Player"):
        player = get_node("/root/Node/Player")

func _on_Item_mouse_entered():
    drag_helper_instance = drag_helper.instance()
    drag_helper_instance.set_item(self)
    add_child(drag_helper_instance)
