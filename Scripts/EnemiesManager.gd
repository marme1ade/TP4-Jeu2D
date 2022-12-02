extends Node2D

signal player_bonus(bonus, qty)

var _viewport

func _ready():
	randomize()
	_viewport = get_viewport_rect()

func _physics_process(_delta):
	for enemy in get_children():
		if !(enemy is Enemy): continue

		enemy.position.y += GameVariables.speed
		var enemy_global_position = enemy.get_global_transform_with_canvas().origin

		# L'ennemi n'est pas l'espace de jeu
		if (enemy_global_position.x > _viewport.size.x || enemy_global_position.x < 0 
			|| enemy_global_position.y >= _viewport.size.y + 50):
				if (enemy.has_entered_game):
					enemy.queue_free()
		elif !enemy.has_entered_game: # L'ennemi a atteint l'espace de jeu pour la premiere fois
			enemy.has_entered_game = true


func spawn_enemy(enemy_type):
	var enemy_instance = Constants.enemy_template[enemy_type].instance()
	enemy_instance.connect("enemy_died", self, "_on_Enemy_died")

	var rand_dir = randi() % 2
	enemy_instance.init(rand_dir, _enemy_speed())

	if (rand_dir == 0):
		enemy_instance.position = Vector2(-50, 50)
	else:
		enemy_instance.position = Vector2(get_viewport ().get_visible_rect ().size.x +50, 50)

	add_child(enemy_instance)

func _enemy_speed()->int:
	var base_speed = 75

	match (GameVariables.speed):
		2:
			base_speed = 80
		3:
			base_speed = 80
		_:
			pass
	
	return base_speed + randi() % int(0.40*base_speed)

func _on_Enemy_died(enemy):
	if enemy.id == Constants.Enemy.dog2:
		emit_signal("player_bonus", Constants.Bonus.live, 1)

	var explosion = Constants.EXPLOSION.instance()
	explosion.position = enemy.position
	enemy.queue_free()
	add_child(explosion)
