extends RayCast2D

onready var light := $Light

var length
var angle

func _ready():
	pass # Replace with function body.


func face(cast: Vector2):
	var dispVec = cast - position
	set_cast_to(dispVec.rotated(angle).normalized() * length)

func drawLight(point1: Vector2, point2: Vector2):
	var points = PoolVector2Array()
	points.append(point1)
	points.append(point2)
	
	light.set_points(points)
