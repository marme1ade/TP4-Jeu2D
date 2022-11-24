extends KinematicBody2D

const PROJECTILE_PATH = "res://Scenes/ProjectileSouris.tscn"

export var _walk_speed = 300
export var _slide = 16

var _projectile_time_limiter = 0.5
var _projectile_time_remaining = 0
var _velocity = 0
var _direction = Vector2()

onready var _animated_sprite = $AnimatedSprite
onready var _projectile_template = preload(PROJECTILE_PATH)

func _physics_process(_delta):
	var vector_direction = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		_velocity = _walk_speed
		vector_direction += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		_velocity =  _walk_speed
		vector_direction += Vector2(1,0)

	if _velocity == _walk_speed: # Le joueur se déplace
		_direction = vector_direction.limit_length(1)

		var animation
		match (_direction):
			Vector2(-1,0): # Gauche
				if (_velocity == _walk_speed):
					animation = "Left"
			Vector2(1,0): # Droite
				if (_velocity == _walk_speed):
					animation = "Right"
			Vector2(0,0): # Marche vers l'avant
				animation = "Forward"
			_:
				animation = null
		if (animation != null):
			_animated_sprite.play(animation)

	else: # Le joueur ne se deplace pas vers la gauche ou la droite
		_animated_sprite.play("Forward")

	if _velocity > 0:
		_velocity -= _slide
	else:
		_velocity = 0

	move_and_slide(_velocity * _direction)

	if Input.is_action_just_pressed("ui_up"):
		shoot_projectile()

func shoot_projectile():
	#if _projectile_time_remaining <= 0:
		_projectile_time_remaining = _projectile_time_limiter
		var projectile = _projectile_template.instance()
		projectile.init(transform.origin, Vector2(0,-1))
		get_parent().add_child(projectile)