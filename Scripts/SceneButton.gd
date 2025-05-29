extends Control
class_name SceneButton

export var transitionScene : String
export var transitionOn : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "onPlayButtonPressed")
	connect("mouse_entered", self, "onMouseEnter")
	
func onPlayButtonPressed():
	Global.audioManager.playSelect()
	Global.sceneManager.setGUI(transitionScene, transitionOn)
	if transitionOn:
		Global.audioManager.setBgSong(0)

func onMouseEnter():
	Global.audioManager.playOnButton()
