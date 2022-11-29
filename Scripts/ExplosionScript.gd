extends AnimatedSprite

func _ready():
	self.play()

func _on_Explosion_animation_finished():
	self.queue_free()
