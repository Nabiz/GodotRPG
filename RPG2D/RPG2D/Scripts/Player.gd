extends Area2D

var tile_size = 64
var is_moving = false
 
func _ready():
    position = position.snapped(Vector2.ONE * tile_size)

func _process(delta):
    if !is_moving:
        if Input.is_action_pressed("ui_left"):
            if !is_obstacle(Vector2.LEFT):
                $AnimatedSprite.set_animation("walk_left")
                tween_player(Vector2.LEFT)
        elif Input.is_action_pressed("ui_right"):
            if !is_obstacle(Vector2.RIGHT):
                $AnimatedSprite.set_animation("walk_right")
                tween_player(Vector2.RIGHT)
        elif Input.is_action_pressed("ui_up"):
            if !is_obstacle(Vector2.UP):
                $AnimatedSprite.set_animation("walk_up")
                tween_player(Vector2.UP)
        elif Input.is_action_pressed("ui_down"):
            if !is_obstacle(Vector2.DOWN):
                $AnimatedSprite.set_animation("walk_down")
                tween_player(Vector2.DOWN)

func is_obstacle(vector):
    $RayCast2D.cast_to = vector * tile_size
    $RayCast2D.force_raycast_update()
    return $RayCast2D.is_colliding()

func tween_player(vector):
    is_moving = true
    var tween = $Tween
    $AnimatedSprite.play()
    tween.interpolate_property(self, "position", position,
    position+vector * tile_size, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
    tween.start()

func _on_Tween_tween_all_completed():
    is_moving = false
    $AnimatedSprite.stop()
    $AnimatedSprite.set_frame(0)

