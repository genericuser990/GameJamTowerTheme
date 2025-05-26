extends Sprite

var amplitude = 0.05
var period = 2
var time = 0


func manageSprite(vel, delta):
	# flip sprite
	if (vel.x > 0):
		flip_h = false
	elif (vel.x < 0):
		flip_h = true
		
	time += 1
	offset.y += sin(delta * period * time) * amplitude
