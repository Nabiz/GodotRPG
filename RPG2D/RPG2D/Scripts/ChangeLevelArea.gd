extends Area2D

export var level_scene = "res://Scenes/Levels/Village.tscn"
export var save_game = false

onready var popup = $PanelContainer

var player = null

func _on_ChangeLevelArea_area_entered(area):
    if area.name == "Player":
        area.export_player_info()
        if save_game:
            PlayerInfo.save_data()
        popup.show()

func _on_YES_pressed():
    get_tree().change_scene_to(load(level_scene))

func _on_NO_pressed():
    popup.hide()


func _on_ChangeLevelArea_area_exited(_area):
    popup.hide()
