extends KinematicBody2D

var motion = Vector2()

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150
var heading_left = true

const BULLET = preload("res://Bullet.tscn")

func _physics_process(delta):
	motion.y += GRAVITY
	if is_on_wall():
		heading_left = !heading_left
		$Sprite.flip_h = !heading_left
		
	if heading_left: motion.x = -SPEED
	else: motion.x = SPEED
	
	motion = move_and_slide(motion, UP)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			enemy_hit()

func enemy_hit():
	queue_free()

func _on_Timer_timeout():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.global_transform = global_transform
	bullet.parent_name = get_name()
	if heading_left: bullet.motion.x = -3*SPEED
	else: bullet.motion.x = 3*SPEED
	bullet.get_node("Sprite").flip_h = !heading_left
