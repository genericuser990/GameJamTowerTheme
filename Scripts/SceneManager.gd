extends Node

var currentGUIScene
var currentGameScene
onready var GUI := $GUI
onready var viewPort := $ViewportContainer/Viewport
onready var animationPlayer = $AnimationPlayer
onready var camera := $Camera2D
var startScene = "res://Scenes/ui/StartScreen.tscn"

signal finishTransition

var levelIndex = 0
export var levels : PoolStringArray = [
	"res://Scenes/DebugWorld.tscn",
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn",
	"res://Scenes/Levels/Level3.tscn",
	"res://Scenes/Levels/Level4.tscn",
	"res://Scenes/Levels/Level5.tscn",
	"res://Scenes/Levels/Level6.tscn",
	"res://Scenes/Levels/Level7.tscn"	
]

func _ready():
	# set scene
	var instance = load(startScene).instance()
	currentGUIScene = instance
	GUI.add_child(instance)
	
	# inject self to global
	Global.setSceneManager(self)
	
	Global.connect("onNextLevelTransition", self, "setNextLevel")

# sets control scene
func setGUI(newSceneStr : String = "", isTransition := true):
	#player scene transtion, pause func until done
	if isTransition:
		animationPlayer.play("SceneTransition")
		yield(self, "finishTransition")

	
	# set previouse to null
	if currentGUIScene != null:
		currentGUIScene.queue_free()
	
	# check if null
	if (newSceneStr == ""):
		return
	
	
	var newGUIScene = load(newSceneStr).instance()
	currentGUIScene = newGUIScene
	GUI.add_child(currentGUIScene)


# sets gameplay scene
func setScene(newSceneIndex : int):
	camera.resetCam()
	# set previouse to null
	if currentGameScene != null:
		currentGameScene.queue_free()
	# check if null
	if (newSceneIndex == -1):
		return
	levelIndex = newSceneIndex
	var newGameScene = load(levels[newSceneIndex]).instance()
	currentGameScene = newGameScene
	viewPort.add_child(currentGameScene)

func setNextLevel():
	animationPlayer.play("SceneTransition")
	yield(self, "finishTransition")
	setScene(levelIndex + 1)
	Global.isPaused = false

func reloadCurrentScene():
	currentGameScene.queue_free()
	var newGameScene = load(levels[levelIndex]).instance()
	currentGameScene = newGameScene
	viewPort.add_child(currentGameScene)

func sceneTransitionFin():
	emit_signal("finishTransition")

