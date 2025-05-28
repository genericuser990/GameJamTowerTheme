extends Node

var currentGUIScene
var currentGameScene
onready var GUI := $GUI
onready var viewPort := $ViewportContainer/Viewport
onready var animationPlayer = $AnimationPlayer
var startScene = "res://Scenes/ui/StartScreen.tscn"
var reloadSceneStr

signal finishTransition

export var levels : PoolStringArray = [
	"res://Scenes/DebugWorld.tscn",
	"res://Scenes/Levels/Level1.tscn",
	"res://Scenes/Levels/Level2.tscn",
	"res://Scenes/Levels/Level3.tscn",
	"res://Scenes/Levels/Level4.tscn",
	"res://Scenes/Levels/Level5.tscn",
	"res://Scenes/Levels/Level6.tscn"
]

func _ready():
	# set scene
	var instance = load(startScene).instance()
	currentGUIScene = instance
	GUI.add_child(instance)
	
	# inject self to global
	Global.setSceneManager(self)

# sets control scene
func setGUI(newSceneStr : String = ""):
	#player scene transtion, pause func until done
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
func setScene(newSceneStr : String = ""):
	# set previouse to null
	if currentGameScene != null:
		currentGameScene.queue_free()
	# check if null
	if (newSceneStr == ""):
		return
	
	reloadSceneStr = newSceneStr
	var newGameScene = load(newSceneStr).instance()
	currentGameScene = newGameScene
	viewPort.add_child(currentGameScene)

func reloadCurrentScene():
	currentGameScene.queue_free()
	var newGameScene = load(reloadSceneStr).instance()
	currentGameScene = newGameScene
	viewPort.add_child(currentGameScene)

func sceneTransitionFin():
	emit_signal("finishTransition")
