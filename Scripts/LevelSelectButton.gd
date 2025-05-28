extends TextureButton

export var level : int = 0

func _ready():

	connect("pressed", self, "_on_LevelSelectButton_pressed")
	connect("mouse_entered", self, "onMouseEnter")

func _on_LevelSelectButton_pressed():
	Global.audioManager.playSelect()
	Global.isPaused = false
	Global.sceneManager.setScene(level)
	Global.sceneManager.setGUI("res://Scenes/ui/Gameplay.tscn")
	Global.audioManager.setBgSong(1)

func onMouseEnter():
	Global.audioManager.playOnButton()
