extends Node


signal restartLevel
signal nextLevel

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var boats := [$Boat]
var detected = false

func _physics_process(delta):
	eatBoat()

func eatBoat():
	# Check if boat has been eaten
	for boat in boats:
		if boat.overlaps_body(monster): # I don't think signals work if it's a per object basis?
			if (!detected):
				boat.eaten = true
				boat.hide()
			else:
				emit_signal("restartLevel")
