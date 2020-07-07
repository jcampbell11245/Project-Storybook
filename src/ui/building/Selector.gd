extends Node2D

var parent
const Block = preload("res://src/ui/building/Block.tscn")

func _ready():
	parent = get_parent()

func _process(_delta):
	#Change selector color
	if !Input.is_action_pressed("delete") && $AnimatedSprite.animation != "default":
		$AnimatedSprite.play("default")
	if Input.is_action_pressed("delete") && $AnimatedSprite.animation != "delete":
		$AnimatedSprite.play("delete")
	
	#Create blocks
	if Input.is_action_just_released("place"):
		if not position in parent.blocks.keys():
			var block = Block.instance()
			parent.add_child(block)
			parent.blocks[position] = block
			block.position = position
		free()
		
	#Delete blocks
	elif Input.is_action_just_released("delete"):
		if position in parent.blocks.keys():
			var block = parent.blocks[position]
			parent.blocks.erase(position)
			block.free()
		free()
