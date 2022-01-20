extends Control

func _on_QuitButton_pressed():
    get_tree().change_scene_to(load("res://Scenes/GUI/Menu/Menu.tscn"))
