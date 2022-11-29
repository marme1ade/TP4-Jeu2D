extends Node2D

onready var _enemies_manager = $Enemies;

func _on_EnemySpawnDelay_timeout():
	_enemies_manager.spawn_enemy(Constants.Enemy.values()[randi() % Constants.Enemy.size()])
