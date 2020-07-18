extends Node2D

const BOX_OPEN = preload("res://ItemBoxOpen.tscn")

func open():
	var box_open = BOX_OPEN.instance()
	get_parent().add_child(box_open)
	box_open.global_transform = self.global_transform
	queue_free()
	
func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		call_deferred("open")
