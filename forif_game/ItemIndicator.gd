extends Control

signal item_expire

const TIME_LIMIT = 5.0

const sprites = [
	preload("res://heart2.png"), # ERROR INDICATOR IF ITEM_CODE IS NULL
	preload("res://Sprites/mop.png"),
	preload("res://Sprites/sweep.png"),
	preload("res://Sprites/bag.png"),
	preload("res://heart.png")
]

func _ready():
	$ItemIndicator.texture = null

func _on_Timer_timeout():
	$ItemIndicator.texture = null
	emit_signal("item_expire")

func _process(delta):
	$ItemTimeIndicator.value = $Timer.time_left

func _on_Player_item_equip(code):
	$ItemIndicator.texture = sprites[code]
	$Timer.start(TIME_LIMIT)
	$ItemTimeIndicator.max_value = TIME_LIMIT
	$ItemTimeIndicator.value = TIME_LIMIT
