extends Node

const ENEMY_PATHS = [
	"res://Scenes/Enemies/Racoon.tscn",
	"res://Scenes/Enemies/Dog1.tscn",
	"res://Scenes/Enemies/Dog2.tscn",]

const LEVEL_PATHS = [ # TODO Ajouter un deuxieme niveau
	"res://Scenes/Level1.tscn",
]

const MAX_LEVEL = len(LEVEL_PATHS)

const EXPLOSION = preload("res://Scenes/Explosion.tscn")

enum Enemy {
	racoon,
	dog1,
	dog2,
}

enum Bonus {
	live,
}

var enemy_template = []
var levels = []

func _ready():
	for path in ENEMY_PATHS:
		enemy_template.append(load(path))
	
	for path in LEVEL_PATHS:
		levels.append(load(path))
