extends Control

var parent
const Block = preload("res://src/ui/building/Block.tscn")

const Placing = preload("res://sprites/indicator.png")
const Deleting = preload("res://sprites/delete.png")

func _ready():
	parent = get_parent()

func _process(_delta):
	#Change selector color
	if !Input.is_action_pressed("delete") && $Texture.texture != Placing:
		$Texture.texture = Placing
	if Input.is_action_pressed("delete") && $Texture.texture != Deleting:
		$Texture.texture = Deleting
	
	#Create blocks
	if Input.is_action_just_released("place"):
		if not rect_global_position in parent.blocks.keys():
			var block = Block.instance()
			parent.add_child(block)
			parent.blocks[rect_global_position] = block
			block.position = rect_global_position
		free()
		
	#Delete blocks
	elif Input.is_action_just_released("delete"):
		if rect_global_position in parent.blocks.keys():
			var block = parent.blocks[rect_global_position]
			parent.blocks.erase(rect_global_position)
			block.free()
		free()
