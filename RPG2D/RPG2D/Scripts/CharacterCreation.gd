extends Control

onready var text_edit = $VBoxContainer/MarginContainer/VBoxContainer/TextEdit

var text = "Name"
func _on_TextEdit_text_changed():
    if text_edit.text.length() <= 12:
        text = text_edit.text
    else:
        text_edit.text = text

func _on_QuitButton_pressed():
    get_tree().change_scene_to(load("res://Scenes/GUI/Menu/Menu.tscn"))

func _on_PlayButton_pressed():
    if text.length() > 0:
        get_tree().change_scene_to(load("res://Scenes/Levels/Village.tscn"))
        PlayerInfo.nick = text
