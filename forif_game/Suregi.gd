extends Node2D

export(int) var type = 0

const TEXTURES = [
	preload("res://Sprites/과자 부스러기.png"),
	preload("res://Sprites/먼지.png"),
	preload("res://Sprites/페트병.png")
]
const SCORES = [
	2,
	1,
	5
]

func _ready():
	$Sprite.texture = TEXTURES[type]

func _on_Area2D_body_entered(body):
	if body.has_method("score"):
		body.score(type)
		queue_free()
