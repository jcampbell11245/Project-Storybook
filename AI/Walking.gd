extends KinematicBody2D

export (int) var speed = 850
export (int) var gravity = 3300
export (float, 0, 1.0) var friction = 0.1

export (int) var xmin = null
export (int) var xmax = null

var velocity = Vector2.ZERO
var direction = 1

func _ready():
	print(xmin == 0)
	velocity = Vector2(speed, 0)

func _physics_process(delta):
	velocity.y += gravity * delta
	if is_on_wall() or (xmin != null and position.x < xmin) or (xmax != null and position.x > xmax):
		velocity.x *= -1
	velocity.y = move_and_slide(velocity, Vector2.UP).y
