extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var button := $Button
export var transitionScene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	button.connect("pressed", self, "onPlayButtonPressed")
	
func onPlayButtonPressed():
	Global.audioManager.playSelect()
	Global.sceneManager.setGUI(transitionScene)
