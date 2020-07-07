extends Node2D

var mousePos
var selectorCoords
var selectors = []
var blocks = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	#Stores mouse position
	if(Input.is_action_just_pressed("place") || Input.is_action_just_pressed("delete")):
		mousePos = get_grid_pos(get_global_mouse_position())
	
	#Create selection rectangle
	if(Input.is_action_pressed("place") || Input.is_action_pressed("delete")):
		draw_selection(get_grid_pos(get_global_mouse_position()))
		
	#Clears selectors array
	if(Input.is_action_just_released("place") || Input.is_action_just_released("delete")):
		selectors = []
		
#Draws the selection rectangle
func draw_selection(coords):
	var xDir
	if mousePos.x < coords.x:
		xDir = 1
	else:
		xDir = -1
	var yDir
	if mousePos.y < coords.y:
		yDir = 1
	else:
		yDir = -1
	
	for y in range(mousePos.y, coords.y + 1 * yDir, 64 * yDir):
		for x in range(mousePos.x, coords.x + 1 * xDir, 64 * xDir):
			if !selectors.has(Vector2(x, y)):
						var selector = load("res://Selector.tscn").instance()
						add_child(selector)
						selector.position = Vector2(x, y)
						selectors.append(selector.position)

#Gets the closest position in a 64x64 grid
func get_grid_pos(coords):
	return Vector2(
		floor(coords.x/64) * 64,
		floor(coords.y/64) * 64
	)
