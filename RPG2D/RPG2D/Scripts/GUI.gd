extends Control

var player = null
onready var item_stats = $ItemStats
onready var stats_text = $Panel/VBoxContainer/MarginContainer/TextEdit

onready var helmet_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HelmetSlot
onready var weapon_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/WeaponSlot
onready var armor_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/ArmorSlot
onready var offhand_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/OffhandSlot
onready var shoes_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/ShoesSlot

func _ready():
    if get_node("/root/Node/Player"):
        player = get_node("/root/Node/Player")
        player.set_gui(self)
        set_stats_text()

func _on_Button_pressed():
    get_tree().quit(0)

func set_stats_text():
    stats_text.text = \
    "Attack: " + str(player.min_attack) + "-" + str(player.max_attack) +\
     "\nDefence: " + str(player.def) +\
     "\nMagic Defence: " + str(player.magic_def)


func _on_item_changed():
    var stats = item_stats.get_stats(armor_slot.id)
    player.set_stats(0, 0, stats["def"], 0)
    set_stats_text()
