extends Node2D

func _ready():
	pass

func _process(_delta):
	if Input.is_action_pressed("delete_all") && Input.is_action_just_pressed("delete"):
		get_parent().blocks.erase(position)
		free()
