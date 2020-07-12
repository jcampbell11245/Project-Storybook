extends Control

func _input(event):
	var ink_menu_open = get_parent().get_parent().get_node("InkMenuLayer/InkMenu").visible
	if !ink_menu_open && event.is_action_pressed("pause"):
		pause()

func pause():
		var new_pause_state = !get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
