extends Node

const ENEMY_PATH = [
	"res://Scenes/Enemies/Racoon.tscn",
	"res://Scenes/Enemies/Dog1.tscn",
	"res://Scenes/Enemies/Dog2.tscn",]

const EXPLOSION = preload("res://Scenes/Explosion.tscn")

enum Enemy {
	racoon,
	dog1,
	dog2,
}

var speed = 1
var enemy_template = []
var trippy_mode = false
var speed_up = false

func _ready():
	for path in ENEMY_PATH:
		enemy_template.append(load(path))