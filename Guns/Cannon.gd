extends Area2D

onready var timer = $Timer
onready var muzzle = $Muzzle

var CannonBall = preload("res://Guns/Cannon_Ball.tscn")

func shoot(rotation):
	if timer.time_left == 0:
		var cannonBall = CannonBall.instance()
		cannonBall.position = muzzle.global_position
		cannonBall.rotation_degrees = rotation_degrees
		cannonBall.apply_impulse(Vector2(), Vector2(cannonBall.BULLET_SPEED,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child", cannonBall)
		timer.start()
