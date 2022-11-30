extends Node2D

var _traveled_distance = 0
var _game_has_ended = false

onready var _enemies_manager = $Enemies;

func _speed_up():
	var required_distance = 0

	match (Constants.speed):
		1:
			required_distance = 100
		2:
			required_distance = 300
		3:
			required_distance = 500
		4:
			required_distance = 750
		5:
			required_distance = 900
		_:
			pass
		
	if _traveled_distance >= required_distance || Constants.speed_up: # speed up
		Constants.speed_up = false
		if (Constants.speed + 1 == 6): # Fin du niveau
			# TODO
			pass
		else:
			Constants.speed += 1
			print("Speed ",Constants.speed)
			$EnemySpawnDelay.wait_time = 2.0 / Constants.speed
			

func _on_EnemySpawnDelay_timeout():
	_enemies_manager.spawn_enemy(Constants.Enemy.values()[randi() % Constants.Enemy.size()])


func _on_Chat_end_game():
	Constants.speed = 0
	$EnemySpawnDelay.stop()

	var explosion = Constants.EXPLOSION.instance()
	explosion.position = $Chat.position
	add_child(explosion)
	$Chat.queue_free()
	_game_has_ended = true


func _on_ParallaxBackground_traveled_distance(distance):
	if !_game_has_ended:
		_traveled_distance += distance
		print(_traveled_distance)
		_speed_up()

