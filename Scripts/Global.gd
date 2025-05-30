extends Node

signal onPlayerWin
signal onPlayerReset
signal onNextLevelTransition

var debugControl
var sceneManager : SceneManager
var audioManager

#set in menu
var levelsCompleted = 0

var isPaused := false

func setDebugControl(a):
	debugControl = a

func setSceneManager(a):
	sceneManager = a

func setAudioManager(a):
	audioManager = a
