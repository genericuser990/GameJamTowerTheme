extends Node

var currentGUIScene
var currentGameScene
onready var viewPort := $ViewportContainer/Viewport
var startScene = "res://Scenes/ui/StartScreen.tscn"

func _ready():
	setGUI(startScene)
	Global.setSceneManager(self)

# use Global.sceneManager.setGUI in any script to change gui
func setGUI(newSceneStr : String = ""):
	if currentGUIScene != null:
		currentGUIScene.queue_free()
	
	if (newSceneStr == ""):
		return
	
	var newGUIScene = load(newSceneStr).instance()
	currentGUIScene = newGUIScene
	add_child(currentGUIScene)

func setScene(newSceneStr : String = ""):
	if currentGameScene != null:
		currentGameScene.queue_free()
	
	if (newSceneStr == ""):
		return
		
	var newGameScene = load(newSceneStr).instance()
	currentGameScene = newGameScene
	viewPort.add_child(currentGameScene)

