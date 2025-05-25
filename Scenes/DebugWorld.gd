extends Node

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var lighthouses := [$Lighthouse]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Call this at the beginning so it sees monster immediately
	for lighthouse in lighthouses:
		lighthouse.followMonster(monster.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for lighthouse in lighthouses:
		if (lighthouse.monsterFound):
			lighthouse.followMonster(monster.position)
		
		# Stop following monster if lighthouse can't find it
		var rays = [lighthouse.lineOfSight, lighthouse.rayLeft, lighthouse.rayRight]
		lighthouse.monsterFound = false
		for ray in rays:
			var collider = ray.get_collider()
			if (collider == monster):
				lighthouse.monsterFound = true
