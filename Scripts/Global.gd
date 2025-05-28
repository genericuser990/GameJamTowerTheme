extends Node

signal onPlayerWin
signal onPlayerReset
signal onNextLevelTransition

var debugControl
var sceneManager
var audioManager

var isPaused := false

func setDebugControl(a):
	debugControl = a

func setSceneManager(a):
	sceneManager = a

func setAudioManager(a):
	audioManager = a
