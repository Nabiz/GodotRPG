extends Node2D

tool
var shop_slot_scene = preload("res://Scenes/GUI/ShopSlot.tscn")
var items_dict = {}
export var columns = 5

onready var grid_container = $PanelContainer/GridContainer

func _ready():
    $PanelContainer/GridContainer.columns = columns

func set_items(new_items_dict):
    for item in new_items_dict:
        var shop_slot = shop_slot_scene.instance()
        shop_slot.set_id(item)
        shop_slot.set_price(new_items_dict[item])
        grid_container.add_child(shop_slot)
