extends Node2D

var root_node

# Called when the node enters the scene tree for the first time.
func _ready():
	root_node = get_node("/root/Test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Change selector color
	if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
	if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
		$AnimatedSprite.play("delete")
	
	#Create blocks
	if Input.is_action_just_released("place"):
		if not position in root_node.blocks.keys():
			var block = load("res://Block.tscn").instance()
			root_node.add_child(block)
			root_node.blocks[position] = block
			block.position = position
		free()
		
	#Delete blocks
	elif Input.is_action_just_released("delete"):
		if position in root_node.blocks.keys():
			var block = root_node.blocks[position]
			root_node.blocks.erase(position)
			block.free()
		free()
