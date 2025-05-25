extends Node


signal restartLevel
signal nextLevel

export (PackedScene) var lightSegment

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var lighthouses := [$Lighthouse]
onready var boats := [$Boat]
onready var lights = $Lights

var undetected := false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call this at the beginning so it sees monster immediately
	lightFollow()


func _physics_process(delta):
	lightFollow()
	eatBoat()


func lightFollow():
	# Remove all previously drawn lights
	for child in lights.get_children():
		child.queue_free()
	
	undetected = true
	for lighthouse in lighthouses:
		# Have lighthouse follow monster
		if lighthouse.monsterFound:
			lighthouse.followMonster(monster.position)
		
		# Stop following monster if lighthouse can't find it
		var rays = [lighthouse.lineOfSight, lighthouse.rayLeft, lighthouse.rayRight]
		lighthouse.monsterFound = false
		for ray in rays:
			var collider = ray.get_collider()
			if collider == monster:
				lighthouse.monsterFound = true
				undetected = false
		
			# Draw a line between lighthouse and point of collision
			var collisionPoint = ray.get_collision_point()
			var light = lightSegment.instance()
			if collider:
				light.drawLine(lighthouse.position, collisionPoint)
			else:
				light.drawLine(lighthouse.position, ray.get_cast_to().rotated(PI/12) + lighthouse.position)
				
			lights.add_child(light)
				
func eatBoat():
	# Check if boat has been eaten
	for boat in boats:
		if boat.overlaps_body(monster): # I don't think signals work if it's a per object basis?
			if (undetected):
				boat.eaten = true
				boat.hide()
			else:
				emit_signal("restartLevel")
