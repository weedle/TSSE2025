extends CharacterBody2D

@export var speed = 300
@export var rotation_speed = 1.5
#@export var controller: Script
@export var Flame: PackedScene

var rotation_direction = 0
var movement_direction = 0

func get_input():
	rotation_direction = Input.get_axis("dir_Left", "dir_Right")
	movement_direction = Input.get_axis("dir_Down", "dir_Up")
	if Input.is_action_pressed("fire"):
		for i in range(3):
			var b = Flame.instantiate()
			b.transform = $Muzzle.global_transform
			owner.add_child(b)
	


func slowdown(delta):
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	else:
		velocity = min(1, delta/0.017) * velocity
		
func _physics_process(delta):
	get_input()
	
	velocity += transform.x * movement_direction * 10
	if velocity.length() > speed:
		velocity = speed * velocity.normalized()
		
	rotation += rotation_direction * rotation_speed * delta
	
	if movement_direction == 0:
		slowdown(delta)
		
	move_and_slide()
