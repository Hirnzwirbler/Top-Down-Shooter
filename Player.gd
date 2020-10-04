extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")
var Cannon = preload("res://Cannon.tscn")

export (int) var MAX_SPEED = 300
export (float) var ACCELERATION = 0.1
export (float) var FRICTION = 0.05

onready var muzzle1 = $Muzzle
onready var muzzle2 = $Muzzle2
onready var gun_timer1 = $GunTimer1
onready var gun_timer2 = $GunTimer2

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
	if gun_timer1.time_left == 0:
		shoot_bullet(muzzle1)
		gun_timer1.start()
	if gun_timer2.time_left == 0:
		shoot_cannon(muzzle2)
		gun_timer2.start()
	
func shoot_bullet(muzzle_num):
	var bullet = Bullet.instance()
	bullet.position = muzzle_num.global_position
	bullet.rotation_degrees = rotation_degrees
	bullet.apply_impulse(Vector2(), Vector2(bullet.BULLET_SPEED,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", bullet)
	
func shoot_cannon(muzzle_num):
	var cannon = Cannon.instance()
	cannon.position = muzzle_num.global_position
	cannon.rotation_degrees = rotation_degrees
	cannon.apply_impulse(Vector2(), Vector2(cannon.BULLET_SPEED,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child", cannon)

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
