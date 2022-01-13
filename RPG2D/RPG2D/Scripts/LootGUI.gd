extends Node2D

onready var money_text = $PanelContainer/VBoxContainer2/HBoxContainer2/TextEdit

onready var slots = [$PanelContainer/VBoxContainer2/HBoxContainer/InventorySlot,
$PanelContainer/VBoxContainer2/HBoxContainer/InventorySlot2,
$PanelContainer/VBoxContainer2/HBoxContainer/InventorySlot3, 
$PanelContainer/VBoxContainer2/HBoxContainer/InventorySlot4]

signal money_taken(money)

func _process(_delta):
    if check_empty():
        get_parent().queue_free()

func check_empty():
    if money_text.text == "0" and slots[0].id == 12 and slots[1].id == 12 and slots[2].id == 12 and slots[3].id == 12:
        return true
    else:
        return false

func _on_Button_pressed():
    var money = int(money_text.text)
    money_text.text = "0"
    if money > 0:
        emit_signal("money_taken", money)

func set_loot(money, item0, item1, item2, item3):
    money_text.text = str(money)
    slots[0].set_id(item0)
    slots[1].set_id(item1)
    slots[2].set_id(item2)
    slots[3].set_id(item3)
