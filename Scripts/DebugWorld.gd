extends Node

signal restartLevel
signal nextLevel

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var lighthouses := [$Lighthouse, $Lighthouse2]
onready var boats := [$Boat]

var undetected := false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call this at the beginning so it sees monster immediately
	for lighthouse in lighthouses:
		lighthouse.followMonster(monster.position)


func _physics_process(delta):
	lightFollow()
	
	# Check if boat has been eaten
	for boat in boats:
		if boat.overlaps_body(monster): # I don't think signals work if it's a per object basis?
			if (undetected):
				boat.eaten = true
				boat.hide()
			else:
				emit_signal("restartLevel")


func lightFollow():
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
				
