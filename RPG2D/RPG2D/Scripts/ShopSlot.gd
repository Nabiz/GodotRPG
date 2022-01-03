extends VBoxContainer

tool
export var id = 12 setget set_id
export var price = 100 setget set_price

func set_id(new_id):
    id = new_id
    $Sprite.frame = id
 
func set_price(new_price):
    price = new_price
    $Label.text = str(price)


func _on_BuyButton_pressed():
    var player = get_tree().root.get_child(0).get_node("Player")
    if player:
        if player.gui.get_money() >= price:
            var inventory_slots = player.gui.get_inventory_slots()
            for slot in inventory_slots:
                if slot.id == slot.null_id:
                    player.gui.add_money(-price)
                    slot.set_id(id)
                    print("DUPA KUPIONE")
                    break
