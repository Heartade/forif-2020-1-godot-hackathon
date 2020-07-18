extends Control

export(float) var time_limit = 1000

signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(time_limit)
	$TimeProgress.max_value = time_limit
	$TimeProgress.value = time_limit
	
func _process(delta):
	$TimeProgress.value = $Timer.time_left


func _on_Timer_timeout():
	emit_signal("timeout")
