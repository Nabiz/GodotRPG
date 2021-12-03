extends Control

var player = null
onready var item_stats = $ItemStats
onready var stats_text = $Panel/VBoxContainer/MarginContainer/TextEdit

onready var health_bar = $Panel/VBoxContainer/HealthBar
onready var mana_bar = $Panel/VBoxContainer/ManaBar

onready var money_text = $Panel/VBoxContainer/GoldContainer/GoldText

onready var helmet_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HelmetSlot
onready var weapon_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/WeaponSlot
onready var armor_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/ArmorSlot
onready var offhand_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/OffhandSlot
onready var shoes_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/ShoesSlot
var eq_slots = null

func _ready():
    eq_slots = [helmet_slot, weapon_slot, armor_slot, offhand_slot, shoes_slot]
    if get_parent().get_parent():
        player = get_parent().get_parent()
        set_stats_text()

func set_bars_max_value(max_health, max_mana):
    health_bar.max_value = max_health
    mana_bar.max_value = max_mana
    
func update_bars(health, mana):
    health_bar.value = health
    mana_bar.value = mana

func _on_Button_pressed():
    get_tree().quit(0)

func add_money(money):
    var current_money = int(money_text.text)
    money_text.text = str(current_money + money)

func set_stats_text():
    stats_text.text = \
    "Attack: " + str(player.min_attack) + "-" + str(player.max_attack) +\
     "\nDefence: " + str(player.def) +\
     "\nMagic Defence: " + str(player.magic_def)


func _on_item_changed():
    var min_attack = 0
    var max_attack = 0
    var def = 0
    var magic_def = 0
    
    var stats = null
    for slot in eq_slots:
        stats = item_stats.get_stats(slot.id)
        if stats.get("min_attack"):
            min_attack+=stats.get("min_attack")
        if stats.get("max_attack"):
            max_attack+=stats.get("max_attack")
        if stats.get("def"):
            def+=stats.get("def")
        if stats.get("magic_def"):
            magic_def+=stats.get("magic_def")
    if min_attack == 0:
        min_attack = 1
        max_attack = 2
    player.set_stats(min_attack, max_attack, def, magic_def)
    set_stats_text()
