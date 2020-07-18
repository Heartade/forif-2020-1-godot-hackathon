extends KinematicBody2D

var motion = Vector2()

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 150
var heading_left = true

func _physics_process(delta):
	motion.y += GRAVITY
	if is_on_wall():
		heading_left = !heading_left
		$Sprite.flip_h = !heading_left
		
	if heading_left: motion.x = -SPEED
	else: motion.x = SPEED
	
	motion = move_and_slide(motion, UP)
	
func enemy_hit():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("hit"):
		body.hit()
		enemy_hit()
