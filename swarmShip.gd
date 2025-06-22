extends CharacterBody2D

@export var speed = 20
@export var rotation_speed = 2

@export var leader: CharacterBody2D = null
var hasLeft = false
var hasRight = false
var isLeft = false
var isRight = false

var target = null

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

func slowdown(delta):
	if velocity.length() < 2:
		velocity = Vector2.ZERO
	else:
		velocity = min(1, delta/0.025) * velocity

func _physics_process(delta):
	var pos = Vector2.ZERO
	
	if leader == null:
		# if no leader, we're the leader
		# chase player directly
		target = get_parent().find_child("player")
		pos = target.position
	else:
		# we have a leader
		# find our place in the hierarchy=
		if leader.hasRight == false:
			leader.hasRight = true
			isRight = true
		elif leader.hasLeft == false:
			leader.hasLeft = true
			isLeft = true
		
		var vectorDiff = 20 * Vector2(0, 1).rotated(leader.rotation)
		var vectorDiff2 = 20 * Vector2(-1, 0).rotated(leader.rotation + PI)
		if isRight:
			pos = leader.position - vectorDiff - vectorDiff2
		if isLeft:
			pos = leader.position + vectorDiff - vectorDiff2
		
		
		
	if pos != Vector2.ZERO:
		var dir = find_dir(pos)
		rotation += dir * rotation_speed * delta
		
		if (pos - position).length() > 10:
			velocity = transform.x * speed * delta * 1000
		else:
			slowdown(delta)
	else:
		slowdown(delta)
	


	move_and_slide()
