extends KinematicBody2D

# var는 변수를 선언한다는 의미입니다.
# Vector2는 2차원 벡터 객체를 나타냅니다.
# Vector2()는 Vector2 객체의 기본 생성자로,
# (0, 0) 벡터를 생성합니다.
# 이 구문을 호출한 이후부터 변수 motion은 
# (0, 0) 값을 가진 Vector2 객체를 의미하게 
# 됩니다. 우리는 이 변수를 '플레이어의 움직임'을
# 지정하기 위해 사용할 것입니다.
var motion = Vector2()

# 위쪽 방향 상수입니다.
const UP = Vector2(0, -1)
# 중력입니다.
const GRAVITY = 20
# 이동 속도입니다.
const SPEED = 200
# 점프 시 초기 상승 속도입니다.
const JUMP_SPEED = -600
# 가속도 상수입니다.
const ACCELERATION = 50
# 최대 속도 상수입니다.
const MAX_SPEED = 200

signal hit
var health = 3

signal item_equip
const ITEM_STATUS = ['NONE', 'MOP', 'BROOM', 'BAG', 'HEART']
var current_item = 0

func hit():
	health -= 1
	if health == 0:
		get_tree().reload_current_scene()
	emit_signal("hit", health)
	
# ITEM RETRIEVAL PROCESS:
# 플레이어가 아이템에 접촉하면 get_item()에서 signal item_equip 발령
# ItemIndicator에서 item_equip 시그널을 받아 타이머 가동
# 타이머 만료 시 ItemIndicator에서 item_expire 시그널 발령
func get_item(code):
	if ITEM_STATUS[code] == 'HEART':
		if health < 3: health += 1
	else:
		current_item = code
		emit_signal("item_equip", code)

# func는 함수를 선언한다는 의미입니다.
# _physics_process 함수는 물리적 연산을 수행하는
# 함수로 Godot 엔진 내부에 지정되어 있습니다.
# delta를 인자로 받는데, 이는 지난 Tick부터 시간이
# 몇 초나 지났는지를 의미합니다.
func _physics_process(delta):
	# 마찰 여부입니다.
	var friction = false
	# 세로 방향 속도를 GRAVITY만큼 추가합니다.
	motion.y += GRAVITY
	# if문 문법은 Python과 동일합니다.
	# Input 객체의 static 메소드인 is_action_pressed()
	# 함수를 호출하고 있는데, 이는 특정 동작을 수행하는 키가
	# 지난 Tick 동안 입력되었는지를 의미합니다.
	# 인자로 "ui_right"를 넣어 준 것은 '오른쪽 키'가 눌렸는지
	# 확인하자는 의미입니다.
	if Input.is_action_pressed("ui_left"):
		$Sprite.play("Run")
		# Run 애니메이션
		# 스프라이트를 뒤집습니다.
		$Sprite.flip_h = true
		# motion의 x를 ACCELERATION만큼 왼쪽으로 가속합니다.
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
	elif Input.is_action_pressed("ui_right"):
		# Run 애니메이션
		$Sprite.play("Run")
		# 스프라이트를 뒤집지 않습니다 (뒤집혀 있다면 도로 뒤집습니다).
		$Sprite.flip_h = false
		# motion의 x를 ACCELERATION만큼 오른쪽으로 가속합니다.
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
	else:
		# Idle 애니메이션
		$Sprite.play("Idle")
		# 마찰이 작용합니다.
		friction = true

	if is_on_floor(): # 지상에 있음
		if friction: motion.x = lerp(motion.x, 0, 0.2) # 마찰 작용
		if Input.is_action_just_pressed("ui_up"):
			# 점프!
			motion.y = JUMP_SPEED
	else: # 공기 중
		if friction: motion.x = lerp(motion.x, 0, 0.05) # 마찰 작용
		if motion.y > 50: # 떨어지고 있음
			$Sprite.play("Fall")
		elif motion.y > -50:
			$Sprite.play("Hover")
		else:
			$Sprite.play("Jump")

	
	# KinematicBody를 움직인 뒤 충돌이 발생하면
	# 상대 오브젝트를 밀어냅니다(slide).
	# 1초에 얼마나의 속도(픽셀 단위)로 움직일지를
	# 나타내는 Vector2 객체를 인자로 받습니다.
	# 이로 인해 이번 Tick에서 KinematicBody2D는
	# 초속 (100, 0)의 속도로 움직이게 됩니다.
	motion = move_and_slide(motion, UP)



func _on_ItemIndicator_item_expire():
	current_item = 0
