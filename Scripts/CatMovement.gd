extends KinematicBody2D

export var WALK_SPEED = 300
export var RUN_BONUS = 1.5
export var SLIDE = 16

onready var _animated_sprite = $AnimatedSprite
var prev_animation


var orientation_index = -1

var velocity = 0
var direction = Vector2()
var mouse_direction

func _physics_process(delta):
	var vector_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity = WALK_SPEED
		vector_direction += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		velocity =  WALK_SPEED
		vector_direction += Vector2(1,0)

	if velocity == WALK_SPEED: # Player is moving
		direction = vector_direction.limit_length(1)
		if Input.is_action_pressed("run"):
			velocity = WALK_SPEED * RUN_BONUS

		var animation
		match (direction):
			Vector2(-1,0): # Left
				if (velocity == WALK_SPEED):
					animation = "Left"
			Vector2(1,0): # Right
				if (velocity == WALK_SPEED):
					animation = "Right"
			Vector2(0,0):
				animation = "Forward"
			_:
				animation = null
		if (animation != null):
			_animated_sprite.play(animation)
	else: # Player is idling
		_animated_sprite.play("Forward")

	if velocity > 0:
		velocity -= SLIDE
	else:
		velocity = 0

	move_and_slide(velocity * direction)