class_name Level
extends Node2D

var startPos
var selectors = {}
var blocks = {}

const Selector = preload("res://src/ui/building/Selector.tscn")

func _ready():
	pass

func _process(delta):
	#Stores mouse position
	if(Input.is_action_just_pressed("place") || Input.is_action_just_pressed("delete")):
		startPos = Utils.get_grid_pos(get_global_mouse_position())
	
	#Create selection rectangle
	if(Input.is_action_pressed("place") || Input.is_action_pressed("delete")):
		draw_selection(Utils.get_grid_pos(get_global_mouse_position()))
		
	#Clears selectors array
	if(Input.is_action_just_released("place") || Input.is_action_just_released("delete")):
		selectors = {}
		
#Draws the selection rectangle
func draw_selection(mousePos):
	var xDir = 1 if startPos.x < mousePos.x else -1
	var yDir = 1 if startPos.y < mousePos.y else -1
	
	for pos in selectors.keys():
		if not (
			((startPos.y <= pos.y and pos.y <= mousePos.y) or (mousePos.y <= pos.y and pos.y <= startPos.y)) and
			((startPos.x <= pos.x and pos.x <= mousePos.x) or (mousePos.x <= pos.x and pos.x <= startPos.x))
		):
			selectors[pos].free()
			selectors.erase(pos)
	
	for y in range(startPos.y, mousePos.y + yDir, 64 * yDir):
		for x in range(startPos.x, mousePos.x + xDir, 64 * xDir):
			var pos = Vector2(x, y)
			if not pos in selectors.keys():
				var selector = Selector.instance()
				add_child(selector)
				selector.position = pos
				selectors[pos] = selector
