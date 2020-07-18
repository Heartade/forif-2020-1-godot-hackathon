extends Area2D

# 다음에 불러올 스테이지의 Scene
export(String, FILE, "*.tscn") var next_scene = "World.tscn"

func _physics_process(delta):
	# 충돌 중인 물체의 목록
	var bodies = get_overlapping_bodies()
	# 목록 내의 모든 물체에 대해...
	for body in bodies:
		if body.name == "Player": # 물체의 이름이 "Player"면
			get_tree().change_scene(next_scene) # next_scene으로 이동
