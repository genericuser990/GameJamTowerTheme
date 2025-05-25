extends StaticBody2D


onready var lineOfSight := $LineOfSight
onready var rayLeft := $RayLeft
onready var rayRight := $RayRight

export var rayLength := 100
export var lightAngle := 30 # Maybe should have a better name for this

var monsterFound := true

# Called when the node enters the scene tree for the first time.
func _ready():
	enableRays()
	rayLeft.set_rotation_degrees(lightAngle / 2)
	rayRight.set_rotation_degrees(-lightAngle / 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _physics_process(delta):
	# pass

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
