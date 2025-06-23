extends Area2D

var speed = 750
var lifetime = 0.1

func _ready() -> void:
	var dir = randf_range(-0.3, 0.3)
	rotate(dir)
	speed *= randf_range(0.9, 1.1)

func _physics_process(delta):
	lifetime -= delta
	position += transform.x * speed * delta
	if lifetime <= 0:
		queue_free()

func _on_Bullet_body_entered(body):
	print("hit")
