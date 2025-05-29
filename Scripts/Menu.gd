extends Control

func _ready():
	get_tree().call_group("levelSelectButtons", "unlock", Global.sceneManager.levelIndex)

