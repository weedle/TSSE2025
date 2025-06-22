extends CharacterBody2D

@export var speed = 400
@export var rotation_speed = 1.2

# + means turn right, - means turn left
func find_dir(target: Vector2):
	var diff = target - position
	var ang = atan2(diff[1],diff[0])
	var currAngle = atan2(transform[0][1], transform[0][0])
	var val = ang - currAngle
	val = move_toward(rotation, val, 20)
	if val > PI:
		val -= 2*PI
	if abs(val) < 0.005:
		return 0
	if val > 0:
		return 1
	return -1

func slowdown(delta):
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	else:
		velocity = min(1, delta/0.017) * velocity

func _physics_process(delta):
	var target = Mechanics.getTarget(self)[0]
	var dir = find_dir(target.position)
	rotation += dir * rotation_speed * delta
	
	if (target.position - position).length() > 50:
		velocity = transform.x * delta * speed * 10
	else:
		slowdown(delta)


	move_and_slide()
