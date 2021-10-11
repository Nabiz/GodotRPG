extends Area2D

func _ready():
    pass


func _on_Enemy_mouse_entered():
        print("DUPA")
        $Line2D.show()
