class_name Utils
extends Node

func _ready():
	pass

#Gets the closest position in a 64x64 grid
static func get_grid_pos(mousePos):
	return Vector2(
		floor(mousePos.x/64) * 64,
		floor(mousePos.y/64) * 64
	)
