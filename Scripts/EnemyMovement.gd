extends KinematicBody2D

class_name Enemy
signal enemy_died(enemy)

onready var animated_sprite:AnimatedSprite

var has_entered_game = false
# Direction of enemy, 0 = right, 1 = left
var _direction = 0
var _speed = 1

func _ready():
	animated_sprite = $AnimatedSprite
	if (_direction == 1):
		animated_sprite.flip_h = true

func _physics_process(_delta):
	var direction_vector
	if (_direction == 0):
		direction_vector = Vector2(1,0)
	else:
		direction_vector = Vector2(-1,0)

	move_and_slide(direction_vector * _speed * Constants.speed)

	if !Constants.trippy_mode:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if (collision != null):
				if (collision.collider is Player): # Collision avec le joueur
					collision.collider.hit()
		

func init(direction, speed):
	_direction = direction
	_speed = speed

func hit():
	emit_signal("enemy_died", self)
