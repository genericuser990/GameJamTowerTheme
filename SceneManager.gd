extends Node

var currentGUIScene

func _ready():
	currentGUIScene = $GUI
	Global.setSceneManager(self)

func setGUI(newSceneStr : String):
	currentGUIScene.queue_free()
	var newGUIScene = load(newSceneStr)
	currentGUIScene = newGUIScene
	add_child(newGUIScene)
