extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var isPan = false
var panToCam
var speed = 1
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("onPlayerWin", self, "cameraPan")

func cameraPan(cam):
	panToCam = cam
	isPan = true
	time = 0

func _physics_process(delta):
	if isPan:
		time += 1
		var ratio = delta * speed * time
		position =lerp(position, panToCam.global_position, ratio)
		zoom = lerp(zoom, panToCam.zoom, ratio)
		if ratio >= 1:
			isPan = false

