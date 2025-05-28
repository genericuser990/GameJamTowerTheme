extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var transitionScene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "onPlayButtonPressed")
	connect("mouse_entered", self, "onMouseEnter")
	
func onPlayButtonPressed():
	Global.audioManager.playSelect()
	Global.sceneManager.setGUI(transitionScene)

func onMouseEnter():
	Global.audioManager.playOnButton()
