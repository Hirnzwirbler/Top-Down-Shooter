extends RigidBody2D

export (int) var BULLET_SPEED = 750
export (int) var DAMAGE = 10

onready var timer = $Timer

func _ready():
	timer.start()

func _on_Timer_timeout():
	queue_free()

func _on_Cannon_Ball_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
