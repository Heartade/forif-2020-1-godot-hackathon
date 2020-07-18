extends Area2D

var motion = Vector2()
var parent_name = ""

func _physics_process(delta):
	position += motion * delta

func _on_Bullet_body_entered(body):
	if body.has_method("hit"): body.hit()
	if body.get_name() != parent_name:
		queue_free()
