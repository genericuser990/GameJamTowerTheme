extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var amplitude = 0.005
var period = 1
var time = 0
var eaten := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#rock back and forth
func _physics_process(delta):
	time += 1
	position.x += sin(delta * period * time) * amplitude
