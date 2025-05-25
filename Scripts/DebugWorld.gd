extends Node

onready var monster := $Monster
# Should probably make an array of lighthouses when there are multiple
# Something like all childs of some node being lighthouses?
onready var lighthouse := $Lighthouse

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	lighthouse.followMonster(monster.position)
