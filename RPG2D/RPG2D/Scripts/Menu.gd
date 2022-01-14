extends Control

onready var play_button = $VBoxContainer/MarginContainer/VBoxContainer/PlayButton
onready var reset_button = $MarginContainer/ResetButoon

func _ready():
    var file = File.new()
    if file.file_exists("user://player.json"):
        play_button.text = "Continue"
        reset_button.visible = true

func _on_QuitButton_pressed():
    get_tree().quit(0)


func _on_PlayButton_pressed():
    if play_button.text == "Continue":
        get_tree().change_scene_to(load("res://Scenes/Levels/Village.tscn"))
        PlayerInfo.load_data()
    else:
        pass


var reset_count = -1
func _on_ResetButoon_pressed():
    reset_count+=1
    if reset_count == 0:
        reset_button.text = "Sure?"
    elif reset_count == 1:
        reset_button.text = "RESET!!!"
    elif reset_count == 2:
        var directory = Directory.new()
        directory.remove("user://player.json")
        get_tree().reload_current_scene()
