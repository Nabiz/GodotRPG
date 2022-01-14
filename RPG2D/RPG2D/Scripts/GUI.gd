extends Control

var player = null
onready var item_stats = $ItemStats

onready var attack_text = $Panel/VBoxContainer/StatsContainer/AttackContainer/Attack
onready var def_text = $Panel/VBoxContainer/StatsContainer/DefContainer/Def

onready var health_bar = $Panel/VBoxContainer/HealthBar
onready var mana_bar = $Panel/VBoxContainer/ManaBar

onready var exp_bar = $Panel/VBoxContainer/ExpBar
onready var level_label = $Panel/VBoxContainer/NickContainer/LevelLabel
onready var nick_label = $Panel/VBoxContainer/NickContainer/NameLabel

onready var money_text = $Panel/VBoxContainer/GoldContainer/GoldText

onready var helmet_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HelmetSlot
onready var weapon_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/WeaponSlot
onready var armor_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/ArmorSlot
onready var offhand_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/HBoxContainer/OffhandSlot
onready var shoes_slot = $Panel/VBoxContainer/GridContainerEq/VBoxContainer/ShoesSlot
var eq_slots = null

onready var money_sound = $AudioStreamPlayer
onready var mute_button = $Panel/VBoxContainer/HBoxContainer/MuteButton

func _ready():
    eq_slots = [helmet_slot, weapon_slot, armor_slot, offhand_slot, shoes_slot]
    if get_parent().get_parent():
        player = get_parent().get_parent()
        set_stats_text()
    
    var bus_index = AudioServer.get_bus_index("Master")
    if AudioServer.is_bus_mute(bus_index):
        mute_button.text = "Unmute sound"
    else:
        mute_button.text = "Mute sound"

func set_nick_label(nick):
    nick_label.text = nick

func set_level_label(level):
    level_label.text = "  " + str(level) + " lvl"

func set_bars_max_value(max_health, max_mana, max_exp):
    health_bar.max_value = max_health
    mana_bar.max_value = max_mana
    exp_bar.max_value = max_exp
    
func update_bars(health, mana, experience):
    health_bar.value = health
    mana_bar.value = mana
    exp_bar.value = experience

func _on_Button_pressed():
    get_tree().quit(0)

func add_money(money):
    money_sound.play()
    var current_money = int(money_text.text)
    money_text.text = str(current_money + money)

func get_money():
    return int(money_text.text)

func get_inventory_slots():
    return $Panel/VBoxContainer/GridContainerInventory.get_children()

func set_stats_text():
    attack_text.text = str(player.max_attack)
    def_text.text = str(player.def)

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
        max_attack = 1
    player.set_stats(min_attack, max_attack, def, magic_def)
    set_stats_text()

func _on_MuteButton_pressed():
    var bus_index = AudioServer.get_bus_index("Master")
    if AudioServer.is_bus_mute(bus_index):
        AudioServer.set_bus_mute(bus_index, false)
        mute_button.text = "Mute sound"
    else:
        AudioServer.set_bus_mute(bus_index, true)
        mute_button.text = "Unmute sound"
