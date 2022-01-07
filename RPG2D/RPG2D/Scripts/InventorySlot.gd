extends Panel

var is_mouse_hold = false
var item_scene = preload("res://Scenes/Items/Item.tscn")
var tile_size = 64
var null_id = 12
var id

export var can_drop_item := true

func _ready():
    set_id(null_id)

func set_id(item_id):
    id = item_id
    $Sprite.frame = item_id

func can_drop_data(_position, _data):
    return can_drop_item and id == null_id

func get_drag_data(_position):
    return [id, $Sprite]

func drop_data(_position, data):
    if data:
        id = data[0]
        var item = data[1]
        if item is Sprite:
            item.frame = null_id
            item.get_parent().id = null_id
        else:
            item.queue_free()
        $Sprite.frame = id

func _input(event):
    if event.is_action_released("ui_mouse_left") and is_mouse_hold:
        is_mouse_hold = false
        if get_viewport().get_mouse_position().x < 1600:
            var item = item_scene.instance()
            item.id = id
            get_tree().root.get_child(0).add_child(item)
            item.global_position = (get_global_mouse_position()-Vector2.ONE * tile_size/2).snapped(Vector2.ONE * tile_size) + Vector2.ONE * tile_size/2
            yield(get_tree().create_timer(0.1), "timeout")
            if item.get_overlapping_areas().size() > 0 or item.get_overlapping_bodies().size() > 0:
                item.queue_free()
            else:
                id = null_id
                $Sprite.frame = id

func _on_InventorySlot_gui_input(event):
    if event.is_action_pressed("ui_mouse_left") and !is_mouse_hold:
        is_mouse_hold = true
    if event.is_action_pressed("ui_mouse_right") and !is_mouse_hold:
        var consumable_stats = $ConsumableItemStats.get_consumable_stats(id)
        if consumable_stats:
            var player = get_tree().root.get_child(1).get_node("Player")
            player.eat(consumable_stats.get("health", 0), consumable_stats.get("mana", 0))
            set_id(null_id)
