extends Area2D

var shop_scene = preload("res://Scenes/GUI/Shop.tscn")
var is_shop_opened = false

var player = null
onready var shop = $Shop

var items_dict = {96: 10, 97: 100, 98: 300, 114: 20, 113: 150,
                  118: 50, 116: 200, 117: 500, 83: 10, 81: 250}

func _ready():
    add_items_to_shop()

func add_items_to_shop():
    shop.set_items(items_dict)

func _process(_delta):
    close_shop()

func _input(event):
    if event.is_action_pressed("ui_mouse_right"):
        player = get_parent().get_node("Player")
        if player and not is_shop_opened:
            is_shop_opened = true
            open_shop()

func open_shop():
    shop.visible = true

func close_shop():
    if player and is_shop_opened:
        if global_position.distance_to(player.global_position) >= 1.43 * 64:
            shop.visible = false
            is_shop_opened = false
