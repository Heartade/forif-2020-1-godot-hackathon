extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartGameButton_pressed():
	get_tree().change_scene("res://Bathroom.tscn")


func _on_QuitGameButton_pressed():
	get_tree().quit()


func _on_WhatIsThisButton_pressed():
	get_tree().change_scene("res://WhatIsThis.tscn")
