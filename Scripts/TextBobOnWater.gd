extends Label

export var amplitude = 0.05
export var period = 1
var time = rand_range(1.0,5.0)


func _physics_process(delta):
	time += 1
	rect_position.y += sin(delta * period * time*PI) * amplitude
