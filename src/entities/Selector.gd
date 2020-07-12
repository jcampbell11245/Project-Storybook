extends TextureRect

var positions = [Vector2(3, 67), Vector2(116, 67), Vector2(231, 67), Vector2(344, 67), 
Vector2(3, 151), Vector2(116, 151), Vector2(231, 151), Vector2(344, 151)]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Updates the position of the selector based on the selected item
func update_pos(index):
	rect_position = positions[index]

#Returns the selected position based on the coordinates of the selector
func get_pos():
	return positions.find(rect_position)

#Moves the selector left or right
func move_right_left(index, direction, unlocked_items):
	var x = index % 4
	var y = index / 4
	
	if direction == 1 && x < 3: #Move right
		print("right")
		x = x + 1
	elif direction == -1 && x > 0: #Move down
		print("left")
		x = x - 1
		
	print(x)
	print(y)
	
	var new_pos = y * 4 + x
	if unlocked_items[new_pos]:
		rect_position = positions[new_pos]

#Moves the selector up or down
func move_up_down(index, direction, unlocked_items):
	var x = index % 4
	var y = index / 4
	
	if direction == 1 && y != 0: #Move up
		print("up")
		y = y - 1
	elif direction == -1 && y != 1: #Move down
		print("down")
		y = y + 1
	
	print(x)
	print(y)
	
	var new_pos = y * 4 + x
	if unlocked_items[new_pos]:
		rect_position = positions[new_pos]
