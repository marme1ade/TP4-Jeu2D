extends Node2D


func _physics_process(_delta):
	for enemy in get_children():
		enemy.position.y += Constants.speed
		if enemy.get_global_transform_with_canvas().origin.y >= get_viewport_rect().size.y + 50:
			enemy.queue_free()


func spawn_enemy(enemy_type):
	var enemy_instance = Constants.enemy_template[enemy_type].instance()
	match (enemy_type):
		Constants.Enemy.test:
			enemy_instance.position = Vector2(300, 50)
			add_child(enemy_instance)
		_: # Position de spawn par défaut (en haut de l'écran)
			enemy_instance.position = Vector2(300, 50)
			add_child(enemy_instance)
