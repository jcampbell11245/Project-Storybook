extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/Test").blocks.append(self)


#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shift") && Input.is_action_just_pressed("delete"):
		free()
