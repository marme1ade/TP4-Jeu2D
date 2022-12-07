extends KinematicBody2D

class_name Player

signal player_hit(enemy_type)

const PROJECTILE_PATH = "res://Scenes/ProjectileSouris.tscn"
const PROJECTILE_COOLDOWN = 420 #ms

export var _walk_speed = 300
export var _slide = 16

var _velocity = 0
var _direction = Vector2()
var _last_enemy_hit = null
var _cooldown_projectile = 0

onready var _animated_sprite = $AnimatedSprite
onready var _projectile_template = preload(PROJECTILE_PATH)

func _physics_process(_delta):
	var vector_direction = Vector2.ZERO

	if Input.is_action_just_pressed("ui_select"):
		if _cooldown_projectile <= 0:
			_shoot_projectile()

	if Input.is_action_pressed("ui_left"):
		vector_direction += Vector2(-1,0)
	if Input.is_action_pressed("ui_right"):
		vector_direction += Vector2(1,0)


	if vector_direction != Vector2.ZERO: # Le joueur se déplace
		_direction = vector_direction.limit_length(1)
		_velocity =  _walk_speed * (1+GameVariables.speed*0.15 if !GameVariables.trippy_mode else 2)
		var animation
		match (_direction):
			Vector2(-1,0): # Gauche
				animation = "Left"
			Vector2(1,0): # Droite
				animation = "Right"
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


func _process(delta):
	if _cooldown_projectile > 0: _cooldown_projectile -= delta * 1000 #ms


func hit(enemy):
	if (_last_enemy_hit != enemy):
		_last_enemy_hit = enemy
		emit_signal("player_hit", enemy.id)


func _shoot_projectile():
	var projectile = _projectile_template.instance()
	projectile.init(transform.origin, Vector2(0,-1))
	get_parent().add_child(projectile)
	_cooldown_projectile = PROJECTILE_COOLDOWN
