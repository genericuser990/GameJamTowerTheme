extends KinematicBody2D

export var speed := 100
var vel = Vector2.ZERO
var screenSize
onready var sprite := $TextureRect/MonsterSprite
onready var animation : AnimationPlayer = $AnimationPlayer
onready var tween : Tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("onPlayerWin", self, "eatBoat")
	screenSize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Global.isPaused:
		return
	
	vel.x = Input.get_axis("moveLeft", "moveRight")
	vel.y = Input.get_axis("moveUp", "moveDown")
	
	move_and_slide(vel.normalized() * speed)
	# Prevent moving offscreen
	position.x = clamp(position.x, 5, screenSize.x - 5)
	position.y = clamp(position.y, 5, screenSize.y - 5)
	
	if get_slide_count() > 0:
		checkMoveBox(vel)
	
	# flip sprite
	if (vel.x > 0):
		sprite.flip_h = false
	elif (vel.x < 0):
		sprite.flip_h = true

	if Input.is_action_just_pressed("reset"):
		Global.sceneManager.reloadCurrentScene()

func checkMoveBox(vel):
	if abs(vel.x)+abs(vel.y) > 1:
		return
	var box := get_slide_collision(0).collider as boxClass
	if box:
		box.push(vel)
		
func eatBoat(cam):
	#tween.interpolate_property(self, "position", position, cam.position, 1.2, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	#tween.start()
	
	if sprite.flip_h == true:
		animation.play("eatLeft")
	else:
		animation.play("eatRight")

func onBoat():
	Global.emit_signal("onNextLevelTransition")

