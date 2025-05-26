extends TextureButton

#
export var level : String

func _ready():
	connect("pressed", self, "_on_LevelSelectButton_pressed")

func _on_LevelSelectButton_pressed():
	Global.sceneManager.setScene(level)
	Global.sceneManager.setGUI()
