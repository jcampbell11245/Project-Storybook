extends Control

onready var selector = $Selector
onready var player = get_parent().get_parent().get_parent()

var unlocked_items = [false, false, false, false, false, false, false, false]

func _input(event):
	#Open/close ink menu
	var pauseMenuOpen = get_parent().get_parent().get_node("PauseLayer/Pause").visible
	if !pauseMenuOpen && event.is_action_pressed("ink_menu"):
		open_close_menu()
	
	#Move selector
	if visible:
		var pos = player.ink_move_pos
		if event.is_action_pressed("ui_right"):
			selector.move_right_left(pos, 1, unlocked_items)
			player.ink_move_pos = selector.get_pos()
		elif event.is_action_pressed("ui_left"):
			selector.move_right_left(pos, -1, unlocked_items)
			player.ink_move_pos = selector.get_pos()
		elif event.is_action_pressed("ui_up"):
			selector.move_up_down(pos, 1, unlocked_items)
			player.ink_move_pos = selector.get_pos()
		elif event.is_action_pressed("ui_down"):
			selector.move_up_down(pos, -1, unlocked_items)
			player.ink_move_pos = selector.get_pos()

func open_close_menu():
		var new_pause_state = !get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		
		if visible:
			selector.update_pos(player.ink_move_pos)
		else:
			player.ink_move_pos = selector.get_pos()
			player.update_quick_switch()
			
#Unlocks an item in the ink menu and changes it's texture
func unlock_item(item):
	unlocked_items[item] = true
	
	var textureName
	if item == 0:
		textureName = "pen_stab"
	elif item == 1:
		textureName = "shoot_ink"
	elif item == 2:
		textureName = "whip"
	elif item == 3:
		textureName = "sword"
	elif item == 4:
		textureName = "rifle"
	elif item == 5:
		textureName = "harpoon"
	elif item == 6:
		textureName = "card"
	else:
		textureName = "broomstick"
	
	var texture = load("res://sprites/ink_move_icons/" + textureName + ".png")
	
	var col = item % 4
	var row = item / 4
	get_child(1).get_child(1).get_child(row).get_child(col).texture = texture
