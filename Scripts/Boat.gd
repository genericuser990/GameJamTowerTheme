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
onready var camera := $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "onObjectEnter")
	Global.connect("onNextLevelTransition", self, "getEaten")

#rock back and forth
func _physics_process(delta):
	time += 1
	position.x += sin(delta * period * time) * amplitude

func onObjectEnter(object):
	if object.name == "Monster":
		var eatable = true
		var lighthouses = get_tree().get_nodes_in_group("lighthouses")
		for l in lighthouses:
			if l.isSeeMonster:
				eatable = false
		
		if eatable:
			Global.emit_signal("onPlayerWin", camera)
			Global.isPaused = true


func getEaten():
	sprite.visible = false
	burst.emitting = true
	Global.audioManager.playEatBoat()
