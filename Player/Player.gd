extends KinematicBody2D

export (int) var MAX_SPEED = 300
export (float) var ACCELERATION = 0.1
export (float) var FRICTION = 0.05

var velocity = Vector2()
var guns = []

func _ready():
	if get_child(0).get_children().size() != 0:
		guns = get_child(0).get_children()

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
	for gun in guns:
		gun.shoot(rotation)
	
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
