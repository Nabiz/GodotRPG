extends Area2D

onready var loot_gui = $LootGUI

var tile_size = 64
var player

func _ready():
    loot_gui.visible = false
    if get_node("../Player"):
        player = get_node("../Player")

func set_loot(money, item0, item1, item2, item3):
    loot_gui.set_loot(money, item0, item1, item2, item3)

func _process(_delta):
    if loot_gui.visible and global_position.distance_to(player.global_position) > 1.42*tile_size:
        loot_gui.visible = false

func _input_event(_viewport, event, _shape_idx):
        if event.is_action_pressed("ui_mouse_right"):
            if loot_gui.visible:
                loot_gui.visible = false
            else:
                loot_gui.visible = true

func _on_LootGUI_money_taken(money):
    player.gui.add_money(money)
