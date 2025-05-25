extends StaticBody2D


onready var lineOfSight := $LineOfSight
onready var rayLeft := $RayLeft
onready var rayRight := $RayRight
onready var rays := $Rays

export (PackedScene) var ray

export var rayLength := 100
export var lightAngle := 30 # Maybe should have a better name for this
export var numRays := 10

var monsterFound := true

# Called when the node enters the scene tree for the first time.
func _ready():
	enableRays()
	rayLeft.set_rotation_degrees(lightAngle / 2)
	rayRight.set_rotation_degrees(-lightAngle / 2)
	createRays()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _physics_process(delta): 
	# pass
	
func createRays():
	var deltaAngle = (lightAngle * 1.0) / (numRays - 1)
	for i in numRays:
		var currRay = ray.instance()
		
		currRay.length = rayLength
		currRay.angle = deg2rad(-lightAngle / 2 + (i * deltaAngle))
		currRay.position = position
		
		rays.add_child(currRay)
		

func enableRays():
	lineOfSight.enabled = true
	rayLeft.enabled = true
	rayRight.enabled = true

func followMonster(monsterPos: Vector2):
	# set_cast_to uses relative coordinates from the lighthouse
	var dispVec = monsterPos - position
	var currCast = lineOfSight.get_cast_to()
	var newCast = currCast.linear_interpolate(dispVec.normalized() * rayLength, 0.5)
	
	lineOfSight.set_cast_to(newCast)
	# set_cast_to does not change rotation
	rayLeft.set_cast_to(newCast)
	rayRight.set_cast_to(newCast)
	
	for ray in rays.get_children():
		ray.face(monsterPos)
