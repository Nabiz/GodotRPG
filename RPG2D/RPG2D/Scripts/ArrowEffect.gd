extends Node2D

onready var tween = $Tween



func start_tween(destination):
    look_at(destination)
    tween.interpolate_property(self, "global_position", global_position,
    destination, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    tween.start()

func _on_Tween_tween_all_completed():
    queue_free()
