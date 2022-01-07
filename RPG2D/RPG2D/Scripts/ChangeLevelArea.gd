extends Area2D

export var level_scene = "res://Scenes/Levels/Village.tscn"

func _on_ChangeLevelArea_area_entered(area):
    if area.name == "Player":
        area.export_player_info()
        PlayerInfo.save_data()
        get_tree().change_scene_to(load(level_scene))
