extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var button := $Button
var menuScene := "res://Scenes/ui/Menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "onPlayButtonPressed")
	
func onPlayButtonPressed():
	Global.sceneManager.setGUI(menuScene)
