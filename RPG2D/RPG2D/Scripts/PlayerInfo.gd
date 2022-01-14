extends Node2D

var min_attack = 1
var max_attack = 1
var def = 0
var magic_def = 0

var max_health = 60
var max_mana = 5
var health = 60
var mana = 5

var level = 1
var max_level = 8
var experience = 0
var exp_to_next_level = 50

var money = 0
#var nickname = "Warrior"

var helmet = 12
var weapon = 83
var armor = 12
var offhand = 12
var shoes = 12

var inventory = [224, 224, 224, 12,
                 12, 12, 12, 12,
                 12, 12, 12, 12,
                 12, 12, 12, 12,
                 12, 12, 12, 12,
                ]

func create_dictionary():
    var player_info_dict = {
        "min_attack": min_attack,
        "max_attack": max_attack,
        "def": def,
        "magic_def": magic_def,

        "max_health": max_health,
        "max_mana": max_mana,
        "health": health,
        "mana": mana,

        "level": level,
        "max_level": max_level,
        "experience": experience,
        "exp_to_next_level": exp_to_next_level,

        "money": money,
        #"nickname": "nickname",

        "helmet": helmet,
        "weapon": weapon,
        "armor": armor,
        "offhand": offhand,
        "shoes": shoes,
        "inventory": inventory
    }
    return player_info_dict

func load_data():
    var file = File.new()
    if file.file_exists("user://player.json"):
        file.open("user://player.json", File.READ)
        var player_info_dict = parse_json(file.get_var())
        file.close()
        set_player_info(player_info_dict)
        
func set_player_info(pid):
        min_attack = pid["min_attack"]
        max_attack = pid["max_attack"]
        def = pid["def"]
        magic_def = pid["magic_def"]

        max_health = pid["max_health"]
        max_mana = pid["max_mana"]
        health = pid["health"]
        mana = pid["mana"]

        level = pid["level"]
        max_level = pid["max_level"]
        experience = pid["experience"]
        exp_to_next_level = pid["exp_to_next_level"]

        money = pid["money"]
        #nickname = pid["nickname"]

        helmet = pid["helmet"]
        weapon = pid["weapon"]
        armor = pid["armor"]
        offhand = pid["offhand"]
        shoes = pid["shoes"]
        inventory = pid["inventory"]

func save_data():
    var file = File.new()
    file.open("user://player.json", File.WRITE)
    file.store_var(to_json(create_dictionary()))
    file.close()
