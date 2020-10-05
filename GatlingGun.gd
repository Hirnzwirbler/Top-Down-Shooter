extends Area2D

onready var timer = $Timer
onready var muzzle1 = $Muzzle1
onready var muzzle2 = $Muzzle2
onready var muzzle3 = $Muzzle3

var muzzles = []

var Bullet = preload("res://Bullet.tscn")

func _ready():
	muzzles.append(muzzle1)
	muzzles.append(muzzle2)
	muzzles.append(muzzle3)
	print(muzzles)

func shoot(rotation):
	if timer.time_left == 0:
		var bullet = Bullet.instance()
		muzzles.shuffle()
		bullet.position = muzzles[0].global_position
		bullet.rotation_degrees = rotation_degrees
		bullet.apply_impulse(Vector2(), Vector2(bullet.BULLET_SPEED,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child", bullet)
		timer.start()
