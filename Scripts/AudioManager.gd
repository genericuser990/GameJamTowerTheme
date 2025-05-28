extends Node

onready var eatBoatPlayer = $EatBoat
onready var selectPlayer = $Select
onready var titleSongPlayer = $TitleSong
onready var gameSongPlayer = $GameSong
onready var onButtonPlayer = $OnButton

var currentSong

func _ready():
	currentSong = titleSongPlayer
	currentSong.playing = true
	Global.setAudioManager(self)

func playSelect():
	selectPlayer.playing = true
	
func playEatBoat():
	eatBoatPlayer.playing = true
	
func playOnButton():
	onButtonPlayer.playing = true

func setBgSong(newSong):
	if currentSong != newSong:
		currentSong.playing = false
	currentSong = newSong
	currentSong.playing = true
