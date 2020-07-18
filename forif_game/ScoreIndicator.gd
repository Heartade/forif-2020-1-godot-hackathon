extends Control

# 다음에 불러올 스테이지의 Scene
export(String, FILE, "*.tscn") var next_scene = "World.tscn"
export(String, FILE, "*.tscn") var game_over = "World.tscn"
export(int) var max_score = 30
var score = 0

# Listen to signal on item get
# get_tree().change_scene(next_scene)
func _ready():
	$TextureRect/CenterContainer/Label.text = str(score)+"/"+str(max_score)

func update_score():
	$TextureRect/CenterContainer/Label.text = str(score)+"/"+str(max_score)


func _on_Player_score(val):
	score = score + val
	update_score()


func _on_TimeIndicator_timeout():
	if score >= max_score:
		get_tree().change_scene(next_scene)
	else:
		get_tree().change_scene(game_over)
