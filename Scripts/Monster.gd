extends KinematicBody2D

export var speed := 100
var vel = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vel.x = Input.get_axis("moveLeft", "moveRight")
	vel.y = Input.get_axis("moveUp", "moveDown")
	vel = vel.normalized() * speed
	
	move_and_slide(vel)
