extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
