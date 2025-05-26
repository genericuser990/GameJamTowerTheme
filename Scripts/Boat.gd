extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amplitude = 0.02
var period = 0.5
var time = 0
var eaten := false

onready var sprite := $Boat1
onready var burst := $plankBurst

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("onPlayerWin", self, "getEaten")
	connect("body_entered", self, "onObjectEnter")
	pass # Replace with function body.


#rock back and forth
func _physics_process(delta):
	time += 1
	position.x += sin(delta * period * time) * amplitude

func onObjectEnter(object):
	if object.name == "Monster":
		getEaten()

func getEaten():
	sprite.visible = false
	burst.emitting = true
