extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
		#Update indicator
		var x = get_global_mouse_position().x;
		if(x >= 0):
			if fmod(x, 64.0) < 32:
				x = x - fmod(x, 64.0)
			else:
				x = x + (64 - fmod(x, 64.0))
		else:
			if (64 - fmod(-x, 64.0)) < 32:
				x = x - (64 - fmod(-x, 64.0))
			else:
				x = x + (64 - (64 - fmod(-x, 64.0)))
		var y = get_global_mouse_position().y
		if(y >= 0):
			if fmod(y, 64.0) < 32:
				y = y - fmod(y, 64.0)
			else:
				y = y + (64 - fmod(y, 64.0))
		else:
			if (64 - fmod(-y, 64.0)) < 32:
				y = y - (64 - fmod(-y, 64.0))
			else:
				y = y + (64 - (64 - fmod(-y, 64.0)))
		position = Vector2(x, y)
		
		#Change indicator color
		if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
			$AnimatedSprite.play("default")
		if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
			$AnimatedSprite.play("delete")
