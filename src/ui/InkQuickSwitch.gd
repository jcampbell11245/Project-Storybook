extends HBoxContainer

var icons = []
var menuPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#Updates the ink menu
func update_menu():
	if(icons.size() != 0):
		var leftPos
		if menuPos == 0:
			leftPos = icons.size() - 1
		else:
			leftPos = menuPos - 1
		var rightPos
		if menuPos == icons.size() - 1:
			rightPos = 0
		else:
			rightPos = menuPos + 1
		
		get_child(0).texture = load("res://sprites/ink_move_icons/" + icons[leftPos] + ".png")
		get_child(1).texture = load("res://sprites/ink_move_icons/" + icons[menuPos] + ".png")
		get_child(2).texture = load("res://sprites/ink_move_icons/" + icons[rightPos] + ".png")

#Adds a new ink move icon to the menu
func add_icon(icon):
	icons.append(icon)
	update_menu()

#Shifts the menu one space to the right
func shift_right():
	if menuPos == icons.size() - 1:
		menuPos = 0
	else:
		menuPos += 1
	update_menu()

#Shifts the menu one space to the left
func shift_left():
	if menuPos == 0:
		menuPos = icons.size() - 1
	else:
		menuPos -= 1
	update_menu()

#Returns the currently selected item
func get_selection():
	return icons[menuPos]
