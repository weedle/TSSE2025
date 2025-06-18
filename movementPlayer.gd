extends CharacterBody2D

@export var speed = 200
@export var rotation_speed = 1.1
#@export var controller: Script

var rotation_direction = 0
var movement_direction = 0

func get_input():
	rotation_direction = Input.get_axis("dir_Left", "dir_Right")
	movement_direction = Input.get_axis("dir_Down", "dir_Up")
	velocity += transform.x * movement_direction * 10
	if velocity.length() > speed:
		velocity = speed * velocity.normalized()

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	
	if rotation_direction == 0 and movement_direction == 0:
		if velocity.length() < 5:
			velocity = Vector2.ZERO
		else:
			velocity = min(1, delta/0.018) * velocity
		
	move_and_slide()
