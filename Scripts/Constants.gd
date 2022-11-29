extends Node

const ENEMY_PATH = [
	"res://Scenes/Enemies/Racoon.tscn",
	"res://Scenes/Enemies/Dog1.tscn",
	"res://Scenes/Enemies/Dog2.tscn",]

enum Enemy {
	racoon,
	dog1,
	dog2,
}

var speed = 2
var enemy_template = []

func _ready():
	for path in ENEMY_PATH:
		enemy_template.append(load(path))