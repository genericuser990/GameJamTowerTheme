extends TextureButton

#
export var level : int = 0
var levelScene

func _ready():
	levelScene = Global.sceneManager.levels[level]
	connect("pressed", self, "_on_LevelSelectButton_pressed")
	connect("mouse_entered", self, "onMouseEnter")

func _on_LevelSelectButton_pressed():
	Global.audioManager.playSelect()
	Global.sceneManager.setScene(levelScene)
	Global.sceneManager.setGUI()
	Global.audioManager.setBgSong(1)

func onMouseEnter():
	Global.audioManager.playOnButton()
