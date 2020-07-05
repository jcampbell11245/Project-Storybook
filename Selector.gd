extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#Create blocks
	if Input.is_action_just_released("click"):
		var block = load("res://Block.tscn").instance()
		get_node("/root/Test").add_child(block)
		block.position = position
		free()
