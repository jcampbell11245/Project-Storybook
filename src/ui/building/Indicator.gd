extends Node2D

func _ready():
	pass

func _process(_delta):
	#Update indicator
	position = Utils.get_grid_pos(get_global_mouse_position())
	
	#Change indicator color
	if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
	if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
		$AnimatedSprite.play("delete")
