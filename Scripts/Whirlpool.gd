extends Node


onready var whirlpool1 = $Whirlpool1
onready var whirlpool2 = $Whirlpool2

var isTeleported = false

func _ready():
	whirlpool1.connect("body_entered", self, "onEnterWhirlpool1")
	whirlpool2.connect("body_entered", self, "onEnterWhirlpool2")
	whirlpool1.connect("body_exited", self, "onExitWhirlpool1")
	whirlpool2.connect("body_exited", self, "onExitWhirlpool2")

#func _process(delta):
#	pass

func onEnterWhirlpool1(body):
	if body.name == "Monster" and isTeleported == false:
		Global.emit_signal("whirlpoolEntered")		
		Global.audioManager.playOnWhirlPool()
		body.set_position(whirlpool2.get_global_position())
		isTeleported = true
	
	
func onEnterWhirlpool2(body):
	if body.name == "Monster" and isTeleported == false:
		Global.emit_signal("whirlpoolEntered")				
		Global.audioManager.playOnWhirlPool()		
		body.set_position(whirlpool1.get_global_position())
		isTeleported = true
		

func onExitWhirlpool1(body):
	if body.name == "Monster":
		Global.emit_signal("whirlpoolExited")
		isTeleported = false

func onExitWhirlpool2(body):
	if body.name == "Monster":
		Global.emit_signal("whirlpoolExited")		
		isTeleported = false
