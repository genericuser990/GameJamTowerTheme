extends StaticBody2D


onready var lineOfSight := $LineOfSight
onready var rayLeft := $RayLeft
onready var rayRight := $RayRight
onready var rays := $Rays

export (PackedScene) var ray

export var rayLength := 100
export var lightAngle := 30 # Maybe should have a better name for this
export var degPerRay = 1 # Higher quality when lower

var monsterFound := true

# Called when the node enters the scene tree for the first time.
func _ready():
	lineOfSight.enabled = true
	rayLeft.enabled = true
	rayRight.enabled = true
	rayLeft.set_rotation_degrees(lightAngle / 2)
	rayRight.set_rotation_degrees(-lightAngle / 2)
	createRays()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# func _physics_process(delta): 
	# pass
	
func createRays():
	for i in (lightAngle / degPerRay + 1):
		var currRay = ray.instance()
		
		currRay.length = rayLength
		currRay.angle = -lightAngle / 2 + (i * degPerRay)
		currRay.position = position
		
		currRay.init()
		rays.add_child(currRay)
		

func followMonster(monster: KinematicBody2D):
	# set_cast_to uses relative coordinates from the lighthouse
	var dispVec = monster.position - position
	var currCast = lineOfSight.get_cast_to()
	var newCast = dispVec.normalized() * rayLength
	
	lineOfSight.set_cast_to(newCast)
	# set_cast_to does not change rotation
	rayLeft.set_cast_to(newCast)
	rayRight.set_cast_to(newCast)
	
	for ray in rays.get_children():
		ray.set_cast_to(newCast)
		
		if ray.get_collider():
			# drawLight uses relative coordinates (I think)
			# get_collision_point returns absolute coordinates
			var relCollisionPos = (ray.get_collision_point() - position).rotated(-deg2rad(ray.angle))
			ray.drawLight(Vector2.ZERO, relCollisionPos)
		else:
			ray.drawLight(Vector2.ZERO, newCast)
		
func updateMonsterFound(monster: KinematicBody2D):
	monsterFound = false
	for ray in rays.get_children():
		if (ray.get_collider() == monster):
			monsterFound = true
