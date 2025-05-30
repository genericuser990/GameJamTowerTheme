extends StaticBody2D


onready var rays := $Rays
export (PackedScene) var ray

export var rayLength := 300
export var lightAngle := 15 # Maybe should have a better name for this
export var degPerRay = 1 # Higher quality when lower

export var dirVector = Vector2.UP
export var lightOffset = Vector2(0, 6)
var isSeeMonster := false
var isSearchMonster := true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("lighthouses")
	createRays()
	Global.connect("whirlpoolEntered", self, "onWhirlpoolEntered")
	Global.connect("whirlpoolExited", self, "onWhirlpoolExited")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if isSearchMonster:
		updateIsSeeMonster()
		spreadLight()

func createRays():
	for i in (lightAngle / degPerRay + 1):
		var currRay = ray.instance()
		
		currRay.length = rayLength
		currRay.angle = -lightAngle / 2 + (i * degPerRay)
		currRay.position = $RayPosition.global_position
		
		currRay.init()
		rays.add_child(currRay)
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
			ray.drawLight(Vector2.ZERO, relCollisionPos - $RayPosition.position)
		else:
			ray.drawLight(Vector2.ZERO, newCast)
	
func updateIsSeeMonster():
	isSeeMonster = false
	for ray in rays.get_children():
		if ray.get_collider():
			if ray.get_collider().name == "Monster":
				isSeeMonster = true
				dirVector = ray.get_collider().position + lightOffset - position

func onWhirlpoolEntered():
	isSearchMonster = false
	
func onWhirlpoolExited():
	isSearchMonster = true
