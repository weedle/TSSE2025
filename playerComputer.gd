extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 1.1
#@export var controller: Script

var rotation_direction = 0
var movement_direction = 0

func get_input():
	var delta = 200
	velocity += transform.x * movement_direction * 10
	if velocity.length() > speed:
		velocity = speed * velocity.normalized()
	rotation += rotation_direction * rotation_speed * delta
	
	if rotation_direction == 0 and movement_direction == 0:
		if velocity.length() < 5:
			velocity = Vector2.ZERO
		else:
			velocity = min(1, delta/0.018) * velocity

# + means turn right, - means turn left
func find_dir(target: Vector2):
	var diff = target - position
	var ang = atan2(diff[1],diff[0])
	var currAngle = atan2(transform[0][1], transform[0][0])
	var val = ang - currAngle
	val = move_toward(rotation, val, 10)
	if val > PI:
		val -= 2*PI
	if abs(val) < 0.005:
		return 0
	if val > 0:
		return 1
	return -1

func _physics_process(delta):
	var target = get_parent().find_child("player")
	var dir = find_dir(target.position)
	rotation += dir * rotation_speed * delta
	
	if (target.position - position).length() > 50:
		velocity = transform.x * 5000 * delta
	else:
		if velocity.length() < 5:
			velocity = Vector2.ZERO
		else:
			velocity = min(1, delta/0.018) * velocity


	move_and_slide()
