# Cette implémentation permet le même rendu que Parallax, mais permet la gestion des collisions.

extends Node2D

const LAYER1_OFFSCREEN_POSITION = -719
const LAYER2_FILLSCREEN_POSITION = 478
export var speed = 3

var _active_layer
var _layer1_initial_position
var _layer2_initial_position

onready var _layer1 = $Layer1
onready var _layer2 = $Layer2


func _ready():
	_active_layer = _layer1 # Layer1 est le layer par défaut
	_layer1_initial_position = _layer1.position.y
	_layer2_initial_position = _layer2.position.y


func _physics_process(_delta):
	# Effet de défilement vertical
	_layer1.position.y += speed
	_layer2.position.y += speed

	# Layer2 a pris la position initiale de Layer1. Layer1 prends la position initiale de layer 2 (OFFSCREEN)
	if _active_layer == _layer1 && _layer2.position.y >= LAYER2_FILLSCREEN_POSITION:
		_clear_enemies(_active_layer)
		_active_layer = _layer2;
		_layer1.position.y = LAYER1_OFFSCREEN_POSITION
	
	# Layer1 et layer2 reprends leur place initiale, la boucle recommence
	if _active_layer == _layer2 && _layer1.position.y >= _layer1_initial_position:
		_clear_enemies(_active_layer)
		_active_layer = _layer1
		_layer2.position.y = _layer2_initial_position


func spawn_enemey(enemy_type):
	var enemy_instance = Constants.enemy_template[enemy_type].instance()
	enemy_instance.scale /= _active_layer.scale
	match (enemy_type):
		Constants.Enemy.test:
			enemy_instance.position = Vector2(200, 100)
			_active_layer.add_child(enemy_instance)
			print("Enemy spawned")
		_:
			pass

func _clear_enemies(layer):
	for node in layer.get_children():
		node.free()
		
