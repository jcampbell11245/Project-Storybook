extends Node2D

func _ready():
	pass

func _process(delta):
	#Update indicator
	var x = get_global_mouse_position().x
	x = floor(x/64) * 64
	var y = get_global_mouse_position().y
	y = floor(y/64) * 64
	
	position = Vector2(x, y)
	
	#Change indicator color
	if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
	if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
		$AnimatedSprite.play("delete")
