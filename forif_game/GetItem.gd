extends Node2D

export(int) var item_code = 0

const sprites = [
	preload("res://heart2.png"), # ERROR INDICATOR IF ITEM_CODE IS NULL
	preload("res://Sprites/mop.png"),
	preload("res://Sprites/sweep.png"),
	preload("res://Sprites/bag.png"),
	preload("res://heart.png")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = sprites[item_code]

func _on_Area2D_body_entered(body):
	if body.has_method("get_item"):
		body.get_item(item_code)
		queue_free()
