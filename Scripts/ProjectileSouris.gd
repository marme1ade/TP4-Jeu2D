extends Node

var direction:Vector2
var rb:RigidBody2D
var initial_pos
onready var _animated_sprite = get_node("RigidBody2D/AnimatedSprite")

func _ready():
	rb = get_node("RigidBody2D")
	initial_pos = rb.position
	rb.apply_impulse(Vector2.ZERO,direction * 400)

func init(pos, force):
	self.transform.origin = pos
	direction = force

func _on_RigidBody2D_body_entered(enemy:Node):
	enemy.hit()
	queue_free()
