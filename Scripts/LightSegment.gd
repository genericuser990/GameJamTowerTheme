extends Line2D


func _ready():	
	pass # Replace with function body.


func drawLine(point1: Vector2, point2: Vector2):
	# Godot structure for storing points
	var points = PoolVector2Array()
	points.append(point1)
	points.append(point2)
	
	set_points(points)
