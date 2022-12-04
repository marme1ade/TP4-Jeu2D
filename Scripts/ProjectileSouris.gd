extends Node2D

var direction:Vector2
var rb:RigidBody2D

func _ready():
	rb = get_node("RigidBody2D")
	rb.apply_impulse(Vector2.ZERO,direction * 400)

func _physics_process(_delta):
	# On detruit le projectile lorsqu'il quitte l'espace de jeu
	if rb.get_global_transform_with_canvas().origin.y < 0:
		queue_free()


func init(pos, force):
	transform.origin = pos
	direction = force

func _on_RigidBody2D_body_entered(enemy:Node):
	enemy.hit()
	queue_free()
