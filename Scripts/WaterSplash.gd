extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer := $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "splash")
	timer.wait_time = rand_range(2,5)
	pass # Replace with function body.

func splash():
	timer.wait_time = rand_range(2,5)
	timer.start()
	emitting = true
