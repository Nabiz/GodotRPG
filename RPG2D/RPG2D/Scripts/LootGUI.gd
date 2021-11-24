extends Node2D

onready var money_text = $PanelContainer/VBoxContainer2/HBoxContainer2/TextEdit

func _ready():
    pass

signal money_taken(money)

func _on_Button_pressed():
    var money = int(money_text.text)
    money_text.text = "0"
    emit_signal("money_taken", money)
