extends Node

const ENEMY_PATH = ["res://Scenes/Chat.tscn"]

enum Enemy {
	test,
}

var enemy_template = []

func _ready():
	for path in ENEMY_PATH:
		enemy_template.append(load(path))