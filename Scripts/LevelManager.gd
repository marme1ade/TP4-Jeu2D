extends Node2D

onready var _enemies_manager = $Enemies;


func _ready():
	_enemies_manager.spawn_enemy(Constants.Enemy.test)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

