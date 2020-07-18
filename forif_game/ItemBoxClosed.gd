extends Node2D

const BOX_OPEN = preload("res://ItemBoxOpen.tscn")
const ITEM = preload("res://GetItem.tscn")

func open():
	var box_open = BOX_OPEN.instance()
	var item = ITEM.instance()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	item.item_code = rng.randi_range(1, 4)
	get_parent().add_child(box_open)
	get_parent().add_child(item)
	box_open.global_transform = self.global_transform
	item.global_transform = self.global_transform
	queue_free()
	
func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		call_deferred("open")
