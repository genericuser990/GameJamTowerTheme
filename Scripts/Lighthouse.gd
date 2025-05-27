extends StaticBody2D


onready var rays := $Rays
export (PackedScene) var ray

export var rayLength := 100
export var lightAngle := 30 # Maybe should have a better name for this
export var degPerRay = 1 # Higher quality when lower

export var dirVector = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	createRays()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta): 
	updateMonsterFound()
	spreadLight()

func createRays():
	for i in (lightAngle / degPerRay + 1):
		var currRay = ray.instance()
		
		currRay.length = rayLength
		currRay.angle = -lightAngle / 2 + (i * degPerRay)
		currRay.position = position
		
		currRay.init()
		rays.add_child(currRay)
		currRay.light.set_width(rayLength / 15)
		currRay.add_exception(self)

func spreadLight():
	# set_cast_to uses relative coordinates from the lighthouse
	var newCast = dirVector.normalized() * rayLength
	for ray in rays.get_children():
		ray.set_cast_to(newCast)
		
		if ray.get_collider():
			# drawLight uses relative coordinates (I think)
			# get_collision_point returns absolute coordinates
			var relCollisionPos = (ray.get_collision_point() - position).rotated(-deg2rad(ray.angle))
			ray.drawLight(Vector2.ZERO, relCollisionPos)
		else:
			ray.drawLight(Vector2.ZERO, newCast)
	
func updateMonsterFound():
	for ray in rays.get_children():
		if ray.get_collider():
			if ray.get_collider().name == "Monster":
				dirVector = ray.get_collider().position - position
