extends Control

onready var label1 := $Label
onready var label2 := $Label2
onready var label3 := $Label3
onready var label4 := $Label4
onready var label5 := $Label5

func _ready():
	Global.setDebugControl(self)

func _process(delta):
	label1.text = "Is Teleported" + str(get_parent().get_node("WhirlpoolPair").isTeleported)
