extends SceneButton
export var isPause := false
func _ready():
	pass

func onPlayButtonPressed():
	Global.audioManager.playSelect()
	Global.sceneManager.setGUI(transitionScene, transitionOn)
	Global.isPaused = isPause
