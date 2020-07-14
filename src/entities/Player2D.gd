extends KinematicBody2D

export (int) var speed = 850
export (int) var jump_speed = -1400
export (int) var gravity = 3300
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var ink_move_pos = 0 

var direction = "right"

var velocity = Vector2.ZERO

var rng = RandomNumberGenerator.new()

onready var ink_quick_switch = $Camera/HudLayer/Hud/InkQuickSwitch
onready var ink_menu = $Camera/InkMenuLayer/InkMenu
onready var animator = $AnimationManager
onready var idle_timer = $IdleAnimTimer

func _ready():
	ink_quick_switch.add_icon("pen_stab", ink_move_pos)
	ink_menu.unlock_item(0)
	ink_quick_switch.add_icon("shoot_ink", ink_move_pos)
	ink_menu.unlock_item(1)
	
	idle_timer.start(rng.randi_range(10, 20))

func _process(delta):
	#Plays head nod animation
	if idle_timer.time_left < 1 && (animator.animation == "idle_right" || animator.animation == "idle_left"):
		animator.animation = "nod_" + direction
		idle_timer.start(rng.randi_range(10, 20))
	
	for action in ["jump", "move_left", "move_right", "duck", "attack", "dodge_left", "dodge_right", "pause", "ink_menu", "place", "delete"]:
		if Input.is_action_just_pressed(action):
			idle_timer.start(rng.randi_range(10, 20))
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if velocity.y > 0 && (animator.animation == "jump_right" || animator.animation == "jump_left"):
		animator.animation = "fall_" + direction
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
			if animator.animation == "idle_right" || animator.animation == "walk_right" || animator.animation == "idle_left" || animator.animation == "walk_left":
				animator.animation = "jump_" + direction
				
	if is_on_floor() && (animator.animation == "fall_right" || animator.animation == "fall_left"):
		animator.animation = "idle_" + direction
		
	if animator.animation == "dodge_right" && animator.frame == 10:
		animator.animation = "idle_left"
	if animator.animation == "dodge_left" && animator.frame == 10:
		animator.animation = "idle_right"

func get_input():
	var quick_switch = Input.is_action_pressed("quick_switch")
	
	#Sets direction variable
	if Input.is_action_just_pressed("move_right"):
		direction = "right"
	elif Input.is_action_just_pressed("move_left"):
		direction = "left"
	
	#Left and right movement
	var dir = 0
	if Input.is_action_pressed("move_right") && !quick_switch:
		dir += 1
		if is_on_floor() && velocity.y >= 0 && !Input.is_action_pressed("duck"):
			animator.animation = "walk_right"
		elif is_on_floor() && velocity.y >= 0 && Input.is_action_pressed("duck"):
			animator.animation = "crawl_right"
		elif animator.animation == "jump_left" || animator.animation == "fall_left":
			animator.animation = "fall_right"
		
	if Input.is_action_pressed("move_left") && !quick_switch:
		dir -= 1
		if is_on_floor() && velocity.y >= 0 && !Input.is_action_pressed("duck"):
			animator.animation = "walk_left"
		elif is_on_floor() && velocity.y >= 0 && Input.is_action_pressed("duck"):
			animator.animation = "crawl_left"
		elif animator.animation == "jump_right" || animator.animation == "fall_right":
			animator.animation = "fall_left"
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if animator.animation == "walk_right" || animator.animation == "walk_left":
			animator.animation = "idle_" + direction
		elif animator.animation == "crawl_right" || animator.animation == "crawl_left":
			animator.animation = "duck_" + direction
	
	#Ducking
	if Input.is_action_just_pressed("duck"):
		$AnimationManager.play("duck_" + direction, false)
		$CollisionShape.shape.extents = Vector2(13, 22)
		move_local_y(6)
		speed = 400
	if Input.is_action_just_released("duck"):
		$AnimationManager.play("idle_" + direction, false)
		$CollisionShape.shape.extents = Vector2(13, 27)
		speed = 850

	#Dodging
	if(Input.is_action_just_pressed("dodge_right")) && $DodgeTimer.time_left == 0 && is_on_floor():
		animator.animation = "dodge_right"
		$DodgeTimer.start(1.0)
		velocity.x += 1500
	if(Input.is_action_just_pressed("dodge_left")) && $DodgeTimer.time_left == 0 && is_on_floor():
		animator.animation = "dodge_left"
		$DodgeTimer.start(1.0)
		velocity.x -= 1500
		
	#Weapon switching
	if(Input.is_action_just_released("next_weapon") || quick_switch && Input.is_action_just_pressed("move_right")):
		ink_move_pos = ink_quick_switch.shift_right(ink_move_pos)
	elif(Input.is_action_just_released("prev_weapon") || quick_switch && Input.is_action_just_pressed("move_left")):
		ink_move_pos = ink_quick_switch.shift_left(ink_move_pos)

#Updates the ink quick switch with the currently selected ink move
func update_quick_switch():
	ink_quick_switch.update_menu(ink_move_pos)
