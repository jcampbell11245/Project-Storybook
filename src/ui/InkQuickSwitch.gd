extends HBoxContainer

var icons = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Updates the ink menu
func update_menu(pos):
	if(icons.size() != 0):
		var left_pos
		if pos == 0:
			left_pos = icons.size() - 1
		else:
			left_pos = pos - 1
		var right_pos
		if pos == icons.size() - 1:
			right_pos = 0
		else:
			right_pos = pos + 1
		
		get_child(0).texture = load("res://sprites/ink_move_icons/" + icons[left_pos] + ".png")
		get_child(1).texture = load("res://sprites/ink_move_icons/" + icons[pos] + ".png")
		get_child(2).texture = load("res://sprites/ink_move_icons/" + icons[right_pos] + ".png")

#Adds a new ink move icon to the menu
func add_icon(icon, pos):
	icons.append(icon)
	update_menu(pos)

#Shifts the menu one space to the right
func shift_right(pos):
	if pos == icons.size() - 1:
		pos = 0
	else:
		pos += 1
	update_menu(pos)
	return pos

#Shifts the menu one space to the left
func shift_left(pos):
	if pos == 0:
		pos = icons.size() - 1
	else:
		pos -= 1
	update_menu(pos)
	return pos

#Returns the currently selected item
func get_selection(pos):
	return icons[pos]
