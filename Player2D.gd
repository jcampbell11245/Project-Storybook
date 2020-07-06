extends KinematicBody2D

export (int) var speed = 850
export (int) var jump_speed = -1400
export (int) var gravity = 3300
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_input():
	#Left and right movement
	var dir = 0
	if Input.is_action_pressed("move_right"):
		dir += 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	#Ducking
	if Input.is_action_just_pressed("duck"):
		$AnimationManager.play("duck", false)
		$CollisionShape.shape.extents = Vector2(32, 32)
		move_local_y(32)
		speed = 400
	if Input.is_action_just_released("duck"):
		$AnimationManager.play("idle", false)
		$CollisionShape.shape.extents = Vector2(32, 64)
		speed = 850

	#Dodging
	if(Input.is_action_just_pressed("dodge_right")) && $DodgeTimer.time_left == 0:
		$DodgeTimer.start(1.0)
		velocity.x += 1500
	if(Input.is_action_just_pressed("dodge_left")) && $DodgeTimer.time_left == 0:
		$DodgeTimer.start(1.0)
		velocity.x -= 1500
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
