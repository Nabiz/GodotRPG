extends "res://Scripts/InventorySlot.gd"

export var type = ""
signal item_changed

var is_item_updated = false

var item_ids_directory = {
    "helmet": [113, 114],
    "hat": [125, 127],
    "sword": [81, 82, 83],
    "rod": [103, 104, 170],
    "armor": [116, 117, 118],
    "robe": [120, 121, 126],
    "shield": [96, 97, 98],
    "book": [212, 215, 289],
    "shoes": [130, 131],
    }

func _process(_delta):
    if id == null_id and !is_item_updated:
        is_item_updated = true
        emit_signal("item_changed")

func can_drop_data(_position, data):
    if id == null_id and data is Array:
        return data[0] in item_ids_directory[type]
    else:
        return false

func drop_data(_position, data):
    .drop_data(_position, data)
    is_item_updated = false
    emit_signal("item_changed")
