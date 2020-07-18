extends Control

const HEART_RED = preload("res://heart.png")
const HEART_BLACK = preload("res://heart2.png")

func _on_Player_hit(health):
	var hearts = [$Heart1, $Heart2, $Heart3]
	for i in 3:
		if i >= health:
			hearts[i].texture = HEART_BLACK
		else:
			hearts[i].texture = HEART_RED
