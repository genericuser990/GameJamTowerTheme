extends Node

var currentGUIScene
var currentGameScene

func _ready():
	setGUI("res://Scenes/StartScreen.tscn")
	Global.setSceneManager(self)

# use Global.sceneManager.setGUI in any script to change gui
func setGUI(newSceneStr : String):
	if currentGUIScene != null:
		currentGUIScene.queue_free()
	var newGUIScene = load(newSceneStr).instance()
	currentGUIScene = newGUIScene
	add_child(currentGUIScene)

func setGame(newSceneStr : String):
	if currentGameScene != null:
		currentGameScene.queue_free()
	var newGameScene = load(newSceneStr).instance()
	currentGameScene = newGameScene
	add_child(currentGameScene)

