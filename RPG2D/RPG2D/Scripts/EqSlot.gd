extends "res://Scripts/InventorySlot.gd"

export var type = ""

var item_ids_directory = {
    "helmet": [114, 115],
    "hat": [125, 127],
    "sword": [81, 82, 83],
    "rod": [103, 104, 170],
    "armor": [116, 117, 118],
    "robe": [120, 121, 126],
    "shield": [96, 97, 98],
    "book": [212, 215, 289],
    "shoes": [130, 131],
    }

func _ready():
    pass

func can_drop_data(_position, data):
    if id == null_id:
        return data[0] in item_ids_directory[type]
    else:
        return false
