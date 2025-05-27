extends KinematicBody2D

export var speed := 100
var vel = Vector2.ZERO
var screenSize
onready var sprite = $TextureRect/MonsterSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	vel.x = Input.get_axis("moveLeft", "moveRight")
	vel.y = Input.get_axis("moveUp", "moveDown")
	vel = vel.normalized() * speed
	
	move_and_slide(vel)
	# Prevent moving offscreen
	position.x = clamp(position.x, 5, screenSize.x - 5)
	position.y = clamp(position.y, 5, screenSize.y - 5)
	
	# flip sprite
	if (vel.x > 0):
		sprite.flip_h = false
	elif (vel.x < 0):
		sprite.flip_h = true

	if Input.is_action_just_pressed("reset"):
		Global.sceneManager.reloadCurrentScene()
