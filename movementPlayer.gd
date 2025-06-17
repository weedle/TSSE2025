extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 1.1

var rotation_direction = 0

func get_input():
	rotation_direction = Input.get_axis("dir_Left", "dir_Right")
	velocity += transform.x * Input.get_axis("dir_Down", "dir_Up") * 10
	if velocity.length() > speed:
		velocity = speed * velocity.normalized()

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	if velocity.length() > 4:
		velocity *= (1 - 0.5 * delta)
	else:
		velocity = Vector2.ZERO
		
	print(velocity.length())
		
	move_and_slide()
