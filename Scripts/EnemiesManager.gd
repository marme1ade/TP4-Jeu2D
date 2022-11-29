extends Node2D

func _ready():
	randomize()

func _physics_process(_delta):
	for enemy in get_children():
		enemy.position.y += Constants.speed
		if enemy.get_global_transform_with_canvas().origin.y >= get_viewport_rect().size.y + 50:
			enemy.queue_free()


func spawn_enemy(enemy_type):
	var enemy_instance = Constants.enemy_template[enemy_type].instance()

	var rand_dir = randi() % 2
	var rand_speed = randi() % 100
	enemy_instance.init(rand_dir, 150 + rand_speed)

	if (rand_dir == 0):
		enemy_instance.position = Vector2(-50, 50)
	else:
		enemy_instance.position = Vector2(get_viewport ().get_visible_rect ().size.x +50, 50)

	add_child(enemy_instance)

