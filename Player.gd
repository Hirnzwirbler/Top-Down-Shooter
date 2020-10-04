extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")
var Cannon = preload("res://Cannon.tscn")

export (int) var MAX_SPEED = 300
export (float) var ACCELERATION = 0.1
export (float) var FRICTION = 0.05

onready var gun1 = $Sprite/Cannon
onready var gun2 = $Sprite/Cannon2

var velocity = Vector2()

func get_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(MAX_SPEED, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-MAX_SPEED, 0).rotated(rotation)
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	gun1.shoot(rotation)
	gun2.shoot(rotation)
	
func shoot_bullet(muzzle_num):
	var bullet = Bullet.instance()
	bullet.position = muzzle_num.global_position
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_impulse(Vector2(), Vector2(bullet.BULLET_SPEED,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet)
	

func move(delta):
	velocity = velocity.normalized() * MAX_SPEED
	if velocity.length() > 0:
		velocity = velocity.linear_interpolate(velocity, ACCELERATION)
	else:
		velocity = velocity.linear_interpolate(Vector2.ZERO, FRICTION)
	velocity = move_and_slide(velocity)

func _process(delta):
	get_input()
	move(delta)
