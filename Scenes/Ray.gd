extends RayCast2D

onready var light := $Light

var length
var angle

func _ready():
	pass # Replace with function body.


func init():
	set_cast_to(Vector2.DOWN * length)
	rotate(deg2rad(angle))
	enabled = true

func drawLight(point1: Vector2, point2: Vector2):
	var points = PoolVector2Array()
	points.append(point1)
	points.append(point2)
	
	light.set_points(points)
