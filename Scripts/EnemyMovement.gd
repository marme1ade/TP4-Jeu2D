extends KinematicBody2D

onready var animated_sprite:AnimatedSprite

# Direction of enemy, 0 = right, 1 = left
var _direction = 0
var _speed = 100

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

	self.move_and_slide(direction_vector * _speed)
		

func init(direction, speed):
	_direction = direction
	_speed = speed
