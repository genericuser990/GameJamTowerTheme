extends TextureButton

export var level : int = 0

onready var lockedTexture = $TextureRect
export var isLocked = true
func _ready():
	add_to_group("levelSelectButtons")
	#isLocked = false
	if !isLocked:
		lockedTexture.visible = false
	
	connect("pressed", self, "_on_LevelSelectButton_pressed")
	connect("mouse_entered", self, "onMouseEnter")

func _on_LevelSelectButton_pressed():
	if !isLocked:
		Global.audioManager.playSelect()
		Global.isPaused = false
		Global.sceneManager.setScene(level)
		Global.sceneManager.setGUI("res://Scenes/ui/Gameplay.tscn")
		Global.audioManager.setBgSong(1)

func onMouseEnter():
	Global.audioManager.playOnButton()

func unlock(index):
	if index >= level:
		isLocked = false
		lockedTexture.visible = false
