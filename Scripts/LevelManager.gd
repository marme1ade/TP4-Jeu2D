extends Node2D

signal player_hit(enemy_type)
signal player_bonus(bonus, qty)
signal next_level
signal enemy_killed

var _traveled_distance = 0
var _level_has_ended = false

onready var _enemies_manager = $Enemies;

func _speed_up():
	var required_distance = 0

	match (GameVariables.speed):
		1:
			required_distance = 50
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
		
	if _traveled_distance >= required_distance || GameVariables.speed_up: # speed up
		GameVariables.speed_up = false
		if (GameVariables.speed + 1 == 6): # Fin du niveau
			$EnemySpawnDelay.stop()
			yield(get_tree().create_timer(4.0), "timeout")
			end_level()
			yield(get_tree().create_timer(3.0), "timeout")
			emit_signal("next_level")
		else:
			GameVariables.speed += 1
			$EnemySpawnDelay.wait_time = 2.0 / GameVariables.speed
			

func _on_EnemySpawnDelay_timeout():
	var random_enemy
	if randf() < 0.1: # 10% de probabilit√©
		random_enemy = Constants.Enemy.dog2
	elif randf() < 0.5:
		random_enemy = Constants.Enemy.racoon
	else:
		random_enemy = Constants.Enemy.dog1

	_enemies_manager.spawn_enemy(random_enemy)



func _on_ParallaxBackground_traveled_distance(distance):
	if !_level_has_ended:
		_traveled_distance += distance
		_speed_up()

func _on_Chat_player_hit(enemy_type):
	emit_signal("player_hit", enemy_type)


func end_level():
	if !_level_has_ended:
		GameVariables.speed = 0
		$EnemySpawnDelay.stop()
		var explosion = Constants.EXPLOSION.instance()
		explosion.position = $Chat.position
		add_child(explosion)
		$Chat.queue_free()
		_level_has_ended = true


func _on_Enemies_player_bonus(bonus, qty):
	emit_signal("player_bonus", bonus, qty)


func _on_Enemies_enemy_killed():
	if !_level_has_ended:
		emit_signal("enemy_killed")
