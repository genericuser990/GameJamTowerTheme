extends Area2D


onready var rightCollision = $RightCollision
onready var leftCollision = $LeftCollision
onready var topCollision = $TopCollision
onready var bottomCollision = $BottomCollision

export var speed := 100

func _ready():
	pass

func _process(delta):
	if get_overlapping_bodies():
		if topCollision.get_overlapping_bodies():
			position += Vector2.DOWN * speed * delta
		elif bottomCollision.get_overlapping_bodies():
			position += Vector2.UP * speed * delta
		elif leftCollision.get_overlapping_bodies():
			position += Vector2.RIGHT * speed * delta
		elif rightCollision.get_overlapping_bodies():
			position += Vector2.LEFT * speed * delta
