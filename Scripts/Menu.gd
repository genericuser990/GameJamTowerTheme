extends Control

func _ready():
	Global.levelsCompleted = max(Global.levelsCompleted, Global.sceneManager.levelIndex)
	get_tree().call_group("levelSelectButtons", "unlock", Global.levelsCompleted)

