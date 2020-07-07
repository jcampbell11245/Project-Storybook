extends Control

const Placing = preload("res://sprites/indicator.png")
const Deleting = preload("res://sprites/delete.png")

func _ready():
	pass

func _process(_delta):
	#Update indicator
	rect_global_position = Utils.get_grid_pos(get_global_mouse_position())
	
	#Change indicator color
	if !Input.is_action_pressed("delete") && $Texture.texture != Placing:
		$Texture.texture = Placing
	if Input.is_action_pressed("delete") && $Texture.texture != Deleting:
		$Texture.texture = Deleting
