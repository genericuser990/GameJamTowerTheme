extends Node


signal restartLevel
signal nextLevel

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var lighthouses := [$Lighthouse]
onready var boats := [$Boat]

var detected := true 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call this at the beginning so it sees monster immediately
	lightFollow()


func _physics_process(delta):
	lightFollow()
	eatBoat()


func lightFollow():
	detected = false
	for lighthouse in lighthouses:
		if lighthouse.monsterFound:
			lighthouse.followMonster(monster)
			
		lighthouse.updateMonsterFound(monster)
		# If any lighthouse finds monster, it is detected
		detected = detected or lighthouse.monsterFound
				
func eatBoat():
	# Check if boat has been eaten
	for boat in boats:
		if boat.overlaps_body(monster): # I don't think signals work if it's a per object basis?
			if (!detected):
				boat.eaten = true
				boat.hide()
			else:
				emit_signal("restartLevel")
