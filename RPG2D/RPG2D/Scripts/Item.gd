extends Node2D

var tile_size = 64
export var id = 96
var player = null

var previous_position

onready var drag_helper= $DragHelper


func _ready():
    previous_position = global_position
    
    $Sprite.frame = id
    drag_helper.set_item(self)
    position = position.snapped(Vector2.ONE * tile_size/2)
    if get_node("/root/Node/Player"):
        player = get_node("/root/Node/Player")
    drag_helper.set_process_input(false)
    drag_helper.visible = false

func _on_Item_mouse_entered():
    drag_helper.set_process_input(true)
    drag_helper.visible = true
