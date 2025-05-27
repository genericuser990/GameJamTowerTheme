extends Node

onready var eatBoatPlayer = $EatBoat
onready var selectPlayer = $Select
onready var titleSongPlayer = $TitleSong

var bgSong

func _ready():
	Global.setAudioManager(self)
	setBgSong(titleSongPlayer)

func playSelect():
	selectPlayer.playing = true
	
func playEatBoat():
	eatBoatPlayer.playing = true

func setBgSong(newSong):
	if bgSong:
		bgSong.playing = false
	bgSong = newSong
	bgSong.playing = true
