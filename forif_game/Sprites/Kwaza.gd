extends Area2D

func _on_Kwaza_body_entered(body):
	if body.has_method("hit"): body.hit()
	if body.get_name() != parent_name:
		queue_free()
