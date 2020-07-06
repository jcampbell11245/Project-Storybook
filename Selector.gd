extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#Change selector color
	if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
	if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
		$AnimatedSprite.play("delete")
	
	#Create blocks
	if Input.is_action_just_released("place"):
		var block = load("res://Block.tscn").instance()
		get_node("/root/Test").add_child(block)
		block.position = position
		free()
		
	#Delete blocks
	elif Input.is_action_just_released("delete"):
		for block in get_node("/root/Test").blocks:
			if block.position.x == position.x && block.position.y == position.y:
					get_node("/root/Test").blocks.erase(block)
					block.free()
		free()
